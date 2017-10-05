//
//  MessageDetailsVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class MessageDetailsVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var replyCommentView : UIView!
    @IBOutlet weak var replyTextView: UITextView!
    
    @IBOutlet weak var replyViewConstraint : NSLayoutConstraint!
    
    var sectionHeader = ["Members", "Reply"]
    var limitTextViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        replyTextView.delegate = self
        replyTextView.circledView(replyTextView.frame.height)
        
        registerObserver()
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
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150.0
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .interactive
        
        registerCellNib("MembersCell", identifier: MessageIdentifier.MessageMemberCell)
        registerCellNib("ContentCell", identifier: MessageIdentifier.MessageContentCell)
        registerCellNib("RepliedCell", identifier: MessageIdentifier.MessageRepliedCell)
    }
    
    func registerCellNib(_ name: String, identifier: String) {
        
        let nibName = UINib(nibName: name, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: identifier)
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
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        expandAndShrinkingTheContentView()
    }
    
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








