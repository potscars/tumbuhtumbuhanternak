//
//  CreateAnnouncementTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

extension NetworkProcessor {
    
    func postRequestJSONFromUrlNoContentType(_ params: [String: Any], completion: @escaping JSONDictionaryHandler) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch let error {
            
            print(error.localizedDescription)
            return
        }
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { completion(nil, error?.localizedDescription); return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == HttpResponsesCode.Success {
                    
                    let httpResponsesString = self.checkResponseStatusCode(httpResponse.statusCode)
                    
                    if let data = data {
                        
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                        
                        completion(jsonData, nil)
                    } else {
                        completion(nil, httpResponsesString)
                    }
                    
                }
            } else {
                completion(nil, "There is no http responses.")
            }
        }
        
        task.resume()
    }
    
}

class CreateAnnouncementTVC: UITableViewController, UITextViewDelegate, UITextFieldDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var subjectText: UITextField? = nil
    var contentText: UITextView? = nil
    var firstTimeEditing: Bool = false
    var imageAndDocumentsInArray: NSMutableArray = []
    
    var projName: String? = nil
    
    
    
    var allValuesToSend: NSMutableDictionary = ["USER_TOKEN": NSNull(),
                                                "PROJ_ID": NSNull(),
                                                "SUBJECT": NSNull(),
                                                "CONTENT": NSNull(),
                                                "IMG_ARRAY": []]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableView(tableView: self)
        ZGraphics.hideTableSeparatorAfterLastCell(tableView: self.tableView)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        
        var rightButton: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_sendmsg.png").resizeImageWith(newSize: CGSize.init(width: 20, height: 20), opaque: false), style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendAnnouncement(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func sendAnnouncement(sender: UIBarButtonItem) {
        
        allValuesToSend.setValue(self.imageAndDocumentsInArray, forKey: "IMG_ARRAY")
        
        let np: NetworkProcessor = NetworkProcessor.init(URLs.sendPengumumanURL)
        let sendAnnoucement: [String:Any] = ["token":String.init(format: "%@", allValuesToSend.value(forKey: "USER_TOKEN") as? String ?? ""),
                                             "project_id":String.init(format: "%i", allValuesToSend.value(forKey: "PROJ_ID") as? Int ?? 0),
                                             "title":String.init(format: "%@", allValuesToSend.value(forKey: "SUBJECT") as? String ?? ""),
                                             "content":String.init(format: "%@", allValuesToSend.value(forKey: "CONTENT") as? String ?? ""),
                                             "image[]":allValuesToSend.value(forKey: "IMG_ARRAY") as! NSArray]
        
        print("ready: \(sendAnnoucement)")
        
        np.postRequestJSONFromUrlNoContentType(sendAnnoucement) { (result, response) in
        
            print("result: \(result)")
            print("response: \(response)")
            
        }
        
    }
    
    func checkFields() {
        
        if let getToken = allValuesToSend.value(forKey: "USER_TOKEN") as? String {
            
            if let getProjID = allValuesToSend.value(forKey: "PROJ_ID") as? Int {
                
                if let getSubject = allValuesToSend.value(forKey: "SUBJECT") as? String {
                    
                    if let getContent = allValuesToSend.value(forKey: "CONTENT") as? String {
                        
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        allValuesToSend.setValue(UserDefaults.standard.object(forKey: "MYA_USERTOKEN"), forKey: "USER_TOKEN")
        
        if let acquiredProjData = AppDelegate.temporaryData as? Projek {
        
            projName = acquiredProjData.name
            self.tableView.reloadData()
            
            allValuesToSend.setValue(acquiredProjData.id, forKey: "PROJ_ID")
            
            checkFields()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        AppDelegate.temporaryData = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("beginUpdates")
        if(firstTimeEditing == false) {
            textView.text = ""
            textView.textColor = UIColor.black
            firstTimeEditing = true
        }
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        //let textView: UITextView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        //textView.text = "treyyy"
        //textView.inputAccessoryView = textView
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if(textView.text == "") {
            textView.text = "Masukkan pernyataan disini..."
            textView.textColor = UIColor.init(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1.0)
            firstTimeEditing = false
            allValuesToSend.setValue(NSNull(), forKey: "CONTENT")
        }
        else {
            allValuesToSend.setValue(textView.text, forKey: "CONTENT")
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("beginUpdates")
        
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("shouldendediting")
        
        if(textField.tag == 383) {
            allValuesToSend.setValue(textField.text, forKey: "SUBJECT")
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("endediting tag")
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        checkFields()
        return true
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            checkFields()
            return false
        }
        return true
    }
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        print("check url: \(url)")
        
    }
    
    func setAddImageButton() {
        
        let imgPicker: BSImagePickerViewController = BSImagePickerViewController.init()
        
        self.bs_presentImagePickerController(imgPicker, animated: true,
        select: { (asset: PHAsset) in
            print("select: aset dipilih : \(asset)")
        }, deselect: { (asset: PHAsset) in
            print("deselect: aset dipilih : \(asset)")
        }, cancel: { (asset: [PHAsset]) in
            print("cancel: aset array dipilih : \(asset)")
        }, finish: { (asset: [PHAsset]) in
            print("finish: aset array dipilih : \(asset)")
            
            let photoManager: PHImageManager = PHImageManager.default()
            let photoManagerOptions: PHImageRequestOptions = PHImageRequestOptions.init()
            photoManagerOptions.isSynchronous = true
            
            for i in 0...asset.count - 1 {
                
                photoManager.requestImage(for: asset[i], targetSize: CGSize.init(width: 1280, height: 720), contentMode: PHImageContentMode.aspectFit, options: photoManagerOptions, resultHandler: { (result, info) -> Void in
                    
                    self.imageAndDocumentsInArray.add(result!)
                
                })
                
            }
            
            DispatchQueue.main.async {
                
                print("Performing table refresh...")
                
                self.tableView.reloadData()
                
            }
            
            
        }) { () -> Void in
            
           
        }
        
    }
    
    func setOpenCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            let alert: UIAlertController = UIAlertController(title: "Camera unavailable", message: "No camera on this device.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if(info[UIImagePickerControllerOriginalImage] as? UIImage != nil) {
            
            let newImageSize: CGSize = CGSize.init(width: 1280, height: 720)
            let originalImage: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            self.imageAndDocumentsInArray.add(newImage)
            
            self.tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(self.imageAndDocumentsInArray.count != 0) { return 3 }
        else { return 2 }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(self.imageAndDocumentsInArray.count != 0) {
            
            if(section == 0) { return 4 }
            else if (section == 1) { return self.imageAndDocumentsInArray.count }
            else { return 1 }
            
        } else {
            
            if(section == 0) { return 4 }
            else { return 1 }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.imageAndDocumentsInArray.count != 0 && indexPath.section == 1)
        {
            //CASelectedImageCellID
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CASelectedImageCellID", for: indexPath) as! CreateAnnouncementTVCell
            
            cell.displayImage(data: self.imageAndDocumentsInArray.object(at: indexPath.row) as! UIImage)
            
                
            return cell
            
        } else if(indexPath.row == 0 && indexPath.section == 0) {
            
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CANameOfSenderCellID", for: indexPath) as! CreateAnnouncementTVCell

            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.getNameOfArticleWriter(data: UserDefaults.standard.object(forKey: "MYA_NAME") as! String)

            return cell
            
        } else if(indexPath.row == 1 && indexPath.section == 0) {
            
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CAProjectNameCellID", for: indexPath) as! CreateAnnouncementTVCell
            
            // Configure the cell...
            if let dataGrab = projName {
                cell.getProjectData(data: dataGrab)
            }
        
            return cell
            
        } else if(indexPath.row == 2 && indexPath.section == 0) {
            
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CASubjectCellID", for: indexPath) as! CreateAnnouncementTVCell
            
            // Configure the cell...
            cell.uitfCATVCSubject.delegate = self
            cell.uitfCATVCSubject.tag = 383
            subjectText = cell.uitfCATVCSubject
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        }else if(indexPath.row == 3 && indexPath.section == 0) {
            
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CAContentCellID", for: indexPath) as! CreateAnnouncementTVCell
            
            // Configure the cell...
            cell.uitvCATVCContent.delegate = self
            cell.uitvCATVCContent.tag = 838
            contentText = cell.uitvCATVCContent
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        } else {
            
            let cell: CreateAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "CAAddImageCellID", for: indexPath) as! CreateAnnouncementTVCell
            
            // Configure the cell...
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if((self.imageAndDocumentsInArray.count == 0 && indexPath.section == 1) || (self.imageAndDocumentsInArray.count != 0 && indexPath.section == 2)) {
            
            let menuImport: UIDocumentMenuViewController = UIDocumentMenuViewController.init(documentTypes: ["public.image"], in: UIDocumentPickerMode.import)
            menuImport.addOption(withTitle: "Gambar dari Photos", image: #imageLiteral(resourceName: "ic_picture.png").resizeImageWith(newSize: CGSize.init(width: 20, height: 20), opaque: false), order: UIDocumentMenuOrder.first, handler: {
                self.setAddImageButton()
                
            })
            menuImport.addOption(withTitle: "Gambar dari Kamera", image: #imageLiteral(resourceName: "ic_photo-camera.png").resizeImageWith(newSize: CGSize.init(width: 20, height: 20), opaque: false), order: UIDocumentMenuOrder.first, handler: {
                self.setOpenCamera()
                
            })
            
            menuImport.delegate = self
            menuImport.modalPresentationStyle = UIModalPresentationStyle.formSheet
            self.navigationController?.present(menuImport, animated: true, completion: nil)
        }
        else if(indexPath.section == 0 && indexPath.row == 1) {
            
            self.performSegue(withIdentifier: "MYA_GOTO_MSG_PROJ", sender: self)
            
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "MYA_GOTO_MSG_PROJ") {
     
            let projVC: GetProjectNVC? = segue.destination as? GetProjectNVC
            projVC?.segueIdentifier = "MYA_GOTO_MSG_PROJ"
        
        }
    }
    

}
