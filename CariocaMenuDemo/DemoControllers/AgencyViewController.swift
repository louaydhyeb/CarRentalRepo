//
//  AgencyViewController.swift
//  CariocaMenuDemo
//
//  Created by Admin on 24/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class AgencyViewController: UIViewController {
     let URLShowAgence = "http://192.168.254.129/Scripts/v1/selectAgence.php"
    let sendFeedback = "http://192.168.254.129/Scripts/v1/addFeedbackAgence.php"
    var stringPassed = ""
    @IBOutlet weak var nameAgence: UILabel!
    @IBOutlet weak var AgencePic: UIImageView!
    @IBOutlet weak var emailAgence: UILabel!
    @IBOutlet weak var phoneAgence: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var addressAgence: UILabel!
    @IBAction func addRate(_ sender: Any) {
    }
    @IBAction func addComment(_ sender: Any) {
        let alert = UIAlertController(title: "Send Feedback", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            let parameters:Parameters=[
                "idUser":UserDefaults.standard.string(forKey: "id")!,
                "agenceId":self.id.text!,
                "feedback":textField!.text!,
                "picture":UserDefaults.standard.string(forKey: "url")!
            ]
            Alamofire.request(self.sendFeedback, method: .post, parameters: parameters).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if json["error"] == false{
                        // let url = String(describing: json["url"])
                        print("Mchettt")
                        print(UserDefaults.standard.string(forKey: "id"))
                        print(self.id.text)
                        print(UserDefaults.standard.string(forKey: "url"))
                        
                    } else if json["error"] == true {
                        print("Can't Load")
                    }
                    print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                    let message = "cannot reach server "
                    let alert2 = UIAlertController(title: "error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert2.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert2, animated: true, completion: nil)
                }
            }
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters:Parameters=[
            "name":stringPassed
            ]
        Alamofire.request(URLShowAgence, method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["error"] == false{
                   // let url = String(describing: json["url"])
                    let name = String(describing: json["name"])
                    let email = String(describing: json["email"])
                    let address = String(describing: json["address"])
                    let phone = String(describing: json["phone"])
                    let url =  URL(string: (json["photo"].stringValue ))
                    print(url)
                    self.nameAgence.text = name
                    self.emailAgence.text = email
                    self.addressAgence.text = address
                    self.phoneAgence.text = phone
                    self.AgencePic.kf.setImage(with: url)
                    self.id.text = String(describing: json["idAgence"])
                    
                    
                    
                } else if json["error"] == true {
                    print("Can't Load")
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
                let message = "cannot reach server "
                let alert2 = UIAlertController(title: "error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert2.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
            }
        }
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
