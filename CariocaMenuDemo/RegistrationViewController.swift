//
//  RegistrationViewController.swift
//  CariocaMenuDemo
//
//  Created by Admin on 03/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import UIKit
import Alamofire
class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photoUrl: URL?
    let URLRegsiter = "http://192.168.254.129/Scripts/v1/registerUser2.php"
    @IBOutlet weak var textUser: UITextField!
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var textPass: UITextField!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtLast: UITextField!
    @IBOutlet weak var textMail: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBAction func choosePicture(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if #available(iOS 11.0, *) {
            if  let imgUrl = info[UIImagePickerControllerImageURL] as? URL{
                let imgName = imgUrl.lastPathComponent
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                let localPath = documentDirectory?.appending(imgName)
                
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                imageUser.image = image
                let data = UIImagePNGRepresentation(image)! as NSData
                data.write(toFile: localPath!, atomically: true)
                //let imageData = NSData(contentsOfFile: localPath!)!
                photoUrl = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
                print(photoUrl)
                picker.dismiss(animated: true, completion: nil)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func Reg(_ sender: UIButton) {
        
        let parameters:Parameters=[
            //"image":photoUrl,
            "username":textUser.text!,
            "password":textPass.text!,
            "email":textMail.text!,
            "phone":txtPhone.text!,
            "firstname":txtFirst.text!,
            "lastname":txtLast.text!,
            "address":txtLocation.text!,
        ]
        
        // Image to upload:
        let imageToUploadURL = photoUrl
        
        // Server address (replace this with the address of your own server):
        //let url = "http://localhost:8888/upload_image.php"
        
        // Use Alamofire to upload the image
        if imageToUploadURL != nil {
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                    multipartFormData.append(imageToUploadURL!, withName: "image")
                    for (key, val) in parameters {
                        multipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
            },
                to: URLRegsiter,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let jsonResponse = response.result.value as? [String: Any] {
                                print(jsonResponse)
                                self.performSegue(withIdentifier: "toLogin", sender: nil)
                            }
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
            Alamofire.request(URLRegsiter,method: .post, parameters: parameters ).responseJSON{
                
                response in
                print(response)
                
                if let result = response.result.value{
                    
                    let jsonData = result as! NSDictionary
                    
                    print(jsonData.value(forKey:"message")as! String? as Any)
                }
            }
        }
        else{
            let message = "Please Upload your picture "
            let alert = UIAlertController(title: "Wrong", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageUser.layer.borderWidth = 1
        imageUser.layer.masksToBounds = false
        imageUser.layer.borderColor = UIColor.black.cgColor
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        imageUser.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
