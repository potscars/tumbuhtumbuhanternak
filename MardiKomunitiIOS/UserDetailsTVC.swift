//
//  UserDetailsTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 12/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

extension NetworkProcessor {
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(_ parameters: [String: Any]?, filePathKey: String, imageData: Data, boundary: String) -> Data {
        var body = Data();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "images"
        
        let mimetype = "image/jpg"
        
        var nameCount = 0
     
        let filePathName = "\(filePathKey)[\(nameCount)]"
        print("Filename = \(filePathName)")
            
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathName)\"; filename=\"\(filename)\(nameCount).jpg\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")
            
        nameCount += 1
    
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func uploadDataMultipart(_ params: [String: Any], image: UIImage, imagesPathKey: String, completion: @escaping JSONDictionaryHandler) {
        
        let boundary = generateBoundaryString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return; }
        
        request.httpBody = createBodyWithParameters(params, filePathKey: imagesPathKey, imageData: imageData, boundary: boundary)
        
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
                else {
                    completion(nil, "Error code \(httpResponse.statusCode)")
                }
            } else {
                completion(nil, "There is no http responses.")
            }
        }
        
        task.resume()
    }
    
}

class UserDetailsTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    var getUserImageURL: String? = nil
    var getUserImage: UIImage = #imageLiteral(resourceName: "ic_userdef.png").resizeImageWith(newSize: CGSize.init(width: 120, height: 150), opaque: false)
    var temporaryUserImage: UIImage = #imageLiteral(resourceName: "ic_userdef.png").resizeImageWith(newSize: CGSize.init(width: 120, height: 150), opaque: false)
    var getUserDataArray: NSArray = []
    var getUserDataDict: NSDictionary = [:]
    
    var getUserLocationArray: NSArray = []
    var getUserLocationData: NSDictionary = [:]
    var getUserLocationDict: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        
        getUserDataArray = UserDefaults.standard.object(forKey: "MYA_ROLES_ARR") as? NSArray ?? []
        getUserDataDict = getUserDataArray.object(at: 0) as? NSDictionary ?? [:]
        
        getUserLocationData = UserDefaults.standard.object(forKey: "MYA_ADDRESS_ARR") as? NSDictionary ?? [:]
        
        getUserImageURL = UserDefaults.standard.object(forKey: "MYA_USERIMAGE") as? String ?? ""
        let getFullImageURL: String =  String.init(format: "%@%@", URLs.loadImage, getUserImageURL!)
        
        let performImages: ZImages = ZImages.init()
        performImages.getImageFromUrlSession(fromURL: getFullImageURL, defaultImage: #imageLiteral(resourceName: "ic_userdef.png"), completionHandler: { (result, response) in
            
            self.getUserImage = result!
            self.tableView.reloadData()
            
        })
    }
    
    func saveToServer() {
        
        let np: NetworkProcessor = NetworkProcessor.init(URLs.updateProfileURL)
        let imageEncapsulation: [UIImage] = [self.temporaryUserImage]
        
        print("imageEncapsulation \(imageEncapsulation)")
        
        np.uploadDataMultipart(["token":String(describing:UserDefaults.standard.object(forKey: "MYA_USERTOKEN"))], images: imageEncapsulation, imagesPathKey: "image", completion: { (result, response) in
            
            if(result != nil) {
                if(result!["status"] as? Int != 0) {
                    print("photo saved")
                    self.getUserImage = self.temporaryUserImage
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Selesai", dialogMessage: "Gambar telah disimpan.", afterDialogDismissed: nil)
                    self.tableView.reloadData()
                } else {
                    print("photo failed to save: \(result)")
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Masalah", dialogMessage: "Gambar gagal disimpan. Sila cuba sebentar lagi.", afterDialogDismissed: nil)
                }
            }
            else {
                ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Masalah", dialogMessage: "Gambar gagal disimpan. Sila cuba sebentar lagi.", afterDialogDismissed: nil)
                
                if(response != nil) { print("PHOTO SAVE SERVER ERROR: \(response!)") }
                else { print("PHOTO SAVE SERVER UNKNOWN ERROR") }
            }
            
        })
        
    }
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    func setAddImageButton() {
        
        let imgPicker: BSImagePickerViewController = BSImagePickerViewController.init()
        
        imgPicker.maxNumberOfSelections = 1
        
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
                    
                    let image: UIImage = result!
                    let checkOrientation: UIImageOrientation = image.imageOrientation
                    
                    if(checkOrientation == UIImageOrientation.up) {
                        
                        print("UIIMAGEORIENTATION UP")
                        
                    } else if(checkOrientation == UIImageOrientation.down) {
                        
                        print("UIIMAGEORIENTATION DOWN")
                        
                    } else if(checkOrientation == UIImageOrientation.left) {
                        
                        print("UIIMAGEORIENTATION LEFT")
                        
                    } else if(checkOrientation == UIImageOrientation.right) {
                        
                        print("UIIMAGEORIENTATION RIGHT")
                        
                    }
                    
                    self.temporaryUserImage = result!
                    self.saveToServer()
                    
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
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            let alert: UIAlertController = UIAlertController(title: "Camera unavailable", message: "No camera on this device.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if(info[UIImagePickerControllerOriginalImage] as? UIImage != nil) {
            
            //let newImageSize: CGSize = CGSize.init(width: 260, height: 320)
            let newImageSize: CGSize = CGSize.init(width: 140, height: 180)
            let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            self.temporaryUserImage = newImage
            self.saveToServer()
            
            DispatchQueue.main.async {
                
            }
            self.tableView.reloadData()
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoBannerCellID", for: indexPath) as! UserDetailsTVCell

            // Configure the cell...
            cell.uiivUDTVCUserAvatar.image = getUserImage

            return cell
            
        } else if(indexPath.row == 1) {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoSubCellID", for: indexPath) as! UserDetailsTVCell
            
            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        } else if(indexPath.row == 2) {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoTwoCellID", for: indexPath) as! UserDetailsTVCell
            
            // Configure the cell...
            cell.updateCellTwoInfo(data: ["TWOINFO_BIGTEXT":UserDefaults.standard.object(forKey: "MYA_NAME") ?? "Tiada maklumat",
                                          "TWOINFO_SUBTEXT":UserDefaults.standard.object(forKey: "MYA_ICNO") ?? "Tiada maklumat",
                                          "TWOINFO_ICONIMAGE":"ic_profile.png"])
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        } else if(indexPath.row == 3) {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoTwoCellID", for: indexPath) as! UserDetailsTVCell
            
            // Configure the cell...
            cell.updateCellTwoInfo(data: ["TWOINFO_BIGTEXT":getUserDataDict.value(forKey: "description") ?? "Tiada maklumat",
                                          "TWOINFO_SUBTEXT":getUserDataDict.value(forKey: "description") ?? "Tiada maklumat",
                                          "TWOINFO_ICONIMAGE":"ic_placepoint.png"])
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        } else if(indexPath.row == 4) {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoOneCellID", for: indexPath) as! UserDetailsTVCell
            
            // Configure the cell...
            cell.updateCellOneInfo(data: ["ONEINFO_BIGTEXT":UserDefaults.standard.object(forKey: "MYA_EMAIL") ?? "Tiada maklumat",
                                          "ONEINFO_ICONIMAGE":"ic_email.png"])
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        } else {
            let cell: UserDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoOneCellID", for: indexPath) as! UserDetailsTVCell
            
            // Configure the cell...
            cell.updateCellOneInfo(data: ["ONEINFO_BIGTEXT":UserDefaults.standard.object(forKey: "MYA_HPNO") ?? "Tiada maklumat",
                                          "ONEINFO_ICONIMAGE":"ic_phone.png"])
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 0) {
            
            let menuImport: UIDocumentMenuViewController = UIDocumentMenuViewController.init(documentTypes: ["public.image"], in: UIDocumentPickerMode.import)
            menuImport.addOption(withTitle: "Gambar dari Photos", image: #imageLiteral(resourceName: "ic_picture.png").resizeImageWith(newSize: CGSize.init(width: 20, height: 20), opaque: false), order: UIDocumentMenuOrder.first, handler: {
                self.setAddImageButton()
                
            })
            menuImport.addOption(withTitle: "Gambar dari Kamera", image: #imageLiteral(resourceName: "ic_photo-camera.png").resizeImageWith(newSize: CGSize.init(width: 20, height: 20), opaque: false), order: UIDocumentMenuOrder.first, handler: {
                self.setOpenCamera()
                
            })
            menuImport.addOption(withTitle: "Buang gambar", image: nil, order: UIDocumentMenuOrder.last, handler: {
                
                
            })
            
            menuImport.delegate = self
            menuImport.modalPresentationStyle = UIModalPresentationStyle.formSheet
            self.navigationController?.present(menuImport, animated: true, completion: nil)
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
