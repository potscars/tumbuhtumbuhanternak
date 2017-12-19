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
    var isFirstTimeLoadMembersCell = true
    let alertController = AlertController()
    var commentPlaceHolder = "Tulis sesuatu.."
    var placeHolderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureTextviewPlaceholder()
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
                self.respondersName = (respondersName?.filterDuplicates { $0 == $1 })!
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
        replyTextView.roundedCorners(3.0)
    }
    
    func registerObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
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
    
    func configureTextviewPlaceholder() {
        
        replyTextView.text = ""
        replyTextView.textColor = .black
        
        //buat label, untuk hold text act as placeholder.
        replyTextView.delegate = self
        placeHolderLabel = UILabel()
        placeHolderLabel.text = "Tulis sesuatu..."
        placeHolderLabel.font = UIFont.italicSystemFont(ofSize: (replyTextView.font?.pointSize)!)
        placeHolderLabel.sizeToFit()
        replyTextView.addSubview(placeHolderLabel)
        placeHolderLabel.frame.origin = CGPoint(x: 5, y: (replyTextView.font?.pointSize)! / 2)
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.isHidden = !replyTextView.text.isEmpty
    }
    
    func registerCellNib(_ name: String, identifier: String) {
        
        let nibName = UINib(nibName: name, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: identifier)
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        spinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        
        //parameters for send messages
        let messageText = replyTextView.text
        let conversationId = message.id
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        
        let networkProcessor = NetworkProcessor.init(URLs.sendConversationRespondURL)
        
        
        if !(messageText?.isEmpty)! && messageText != ""{
            print("Sent")
            
            spinner.setLoadingScreen()
            let params = ["token" : token,
                          "conversation_id" : conversationId!,
                          "message" : messageText!]
            
            networkProcessor.postRequestJSONFromUrl(params, completion: { (result, response) in
                
                guard response == nil else {
                    
                    return;
                }
                
                guard let status = result?["status"] as? Int, status == 1 else {
                    
                    DispatchQueue.main.async {
                        self.alertController.alertController(self, title: "Ralat", message: "Gagal untuk membalas.")
                        self.spinner.removeLoadingScreen()
                    }
                    return;
                }
                
                DispatchQueue.main.async {
                    self.alertController.alertController(self, title: "Berjaya", message: "Mesej anda berjaya dihantarkan.")
                    self.tableView.reloadData()
                    self.replyTextView.text.removeAll()
                    self.spinner.removeLoadingScreen()
                }
            })
        } else {
            self.alertController.alertController(self, title: "Ralat", message: "Sila masukkan mesej terlebih dahulu")
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
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !replyTextView.text.isEmpty
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








