//
//  MessageDetailsVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//


//tableview and collectionview datasource located at MessageDetailsExtension.swift

import UIKit

class MessageDetailsVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var replyCommentView : UIView!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var replyViewConstraint : NSLayoutConstraint!
    
    var sectionHeader = ["Members", "Replies"]
    var limitTextViewHeight: CGFloat!
    var message: Mesej!
    var respondData = [Respond]()
    var respondersName = [String]()
    var isFetched = false
    var collectionCell: MembersCell!
    
    var spinner: LoadingSpinner!
    var tableViewSpinner: LoadingSpinner!
    let alertController = AlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        
        let respond = Respond()
        
        respond.fetchData(message.id!) { (result, respondersName, responses) in
            
            guard responses == nil else {
                //show error message
                return
            }
            
            guard let respondResult = result else { return; }
            
            DispatchQueue.main.async {
                self.respondersName = respondersName!
                self.respondData = respondResult
                self.isFetched = true
                
                self.spinner.stopSpinner()
                let cell = self.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! MembersCell
                cell.collectionView.reloadData()
                
                self.tableViewSpinner.stopSpinner()
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTextview()
        registerObserver()
    }
    
    func configureTextview() {
        
        replyTextView.delegate = self
        replyTextView.circledView(replyTextView.frame.height)
        
        replyTextView.text = "Comment.."
        replyTextView.textColor = .lightGray
    }
    
    func registerObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150.0
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .interactive
        
        registerCellNib("MembersCell", identifier: MessageIdentifier.MessageMemberCell)
        registerCellNib("ContentCell", identifier: MessageIdentifier.MessageContentCell)
        registerCellNib("RepliedCell", identifier: MessageIdentifier.MessageRepliedCell)
        registerCellNib("ErrorCell", identifier: MessageIdentifier.MessageErrorCell)
    }
    
    func registerCellNib(_ name: String, identifier: String) {
        
        let nibName = UINib(nibName: name, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: identifier)
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        let messageText = replyTextView.text
        let conversationId = message.id
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        
        let networkProcessor = NetworkProcessor.init(URLs.sendConversationRespondURL)
        
        
        if replyTextView.textColor != .lightGray && !(messageText?.isEmpty)! {
            print("Sent")
            
            let params = ["token" : token,
                          "conversation_id" : conversationId!,
                          "message" : messageText!]
            
            networkProcessor.postRequestJSONFromUrl(params, completion: { (result, response) in
                
                guard response == nil else {
                    
                    return;
                }
                
                guard let status = result?["status"] as? Int, status == 1 else {
                    self.alertController.alertController(self, title: "Ralat", message: "Gagal untuk membalas.")
                    return;
                }
                
                DispatchQueue.main.async {
                    self.alertController.alertController(self, title: "Berjaya", message: "Mesej anda berjaya dihantarkan.")
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            })
        }
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        
        var userInfo = notification.userInfo
        if let keyboardFrame = (userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.replyCommentView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            })
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.replyCommentView.transform = .identity
        })
    }
}

extension MessageDetailsVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if replyTextView.textColor == .lightGray {
            replyTextView.text = nil
            replyTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if replyTextView.text.characters.count <= 0 {
            
            replyTextView.textColor = .lightGray
            replyTextView.text = "Comment.."
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        expandAndShrinkingTheContentView()
    }
    
    //handle expanding and shrinking replyview.
    func expandAndShrinkingTheContentView() {
        
        let scrollableFrameSize = replyTextView.intrinsicContentSize.height
        print("Intrinsic size : \(scrollableFrameSize)")
        let scrollableContentSize = replyTextView.contentSize.height
        
        if scrollableFrameSize >= replyViewConstraint.constant {
            
            replyTextView.isScrollEnabled = true
        } else if scrollableContentSize < replyViewConstraint.constant {
            
            replyTextView.isScrollEnabled = false
        }
        
        replyCommentView.sizeToFit()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == replyTextView {
            
        }
    }
}








