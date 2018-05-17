//
//  AgencyViewController.swift
//  CariocaMenuDemo
//
//  Created by Admin on 24/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import UIKit

import Kingfisher
import EZLoadingActivity
import Alamofire
import AlamofireImage
import SwiftyJSON
class AgencyViewController: UIViewController {
    
    
    let ratingView = CosmosView()
    
     let URLShowAgence = "http://192.168.254.129/Scripts/v1/selectAgence.php"
    let sendFeedback = "http://192.168.254.129/Scripts/v1/addFeedbackAgence.php"
    var stringPassed = ""
    var url = ""
    @IBOutlet weak var nameAgence: UILabel!
    @IBOutlet weak var interView: UIView!
    @IBOutlet weak var AgencePic: UIImageView!
    @IBOutlet weak var emailAgence: UILabel!
    @IBOutlet weak var phoneAgence: UILabel!
    var ac = 0.0
    @IBAction func rateButton(_ sender: UIButton) {
        
        
        print("Louay")
        let alert = UIAlertController(title: "\n\n", message: "", preferredStyle: .alert)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: alert.view.frame.width, height: alert.view.frame.height))
        
        //The x/y coordinate of the rating view
        let xCoord = alert.view.frame.width/2 - 95 //(5 starts multiplied by 30 each, plus a 5 margin each / 2)
        let yCoord = CGFloat(25.0)
        customView.sizeToFit()
        
        
        
        ratingView.rating = 0.0
        ratingView.settings.starSize = 40
        ratingView.settings.emptyBorderColor = UIColor.black
        ratingView.settings.updateOnTouch = true
        //ratingView.frame.origin.x = xCoord
        //ratingView.frame.origin.y = yCoord
        
        customView.addSubview(ratingView)
        ratingView.didTouchCosmos = didTouchCosmos(_:)
        //alert.addAction(UIAlertAction(title: "Save Rating", style: UIAlertActionStyle.Default, handler: ratingCompletionHandler))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.view.addSubview(customView)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var addressAgence: UILabel!
    
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
            EZLoadingActivity.show("Sending ...", disableUI: false)
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
                        EZLoadingActivity.hide(true, animated: true)
                    } else if json["error"] == true {
                        print("Can't Load")
                        EZLoadingActivity.hide(false, animated: true)
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
    private func didTouchCosmos(_ rating: Double) {
        print(rating)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.AgencePic.layer.cornerRadius = self.AgencePic.frame.size.width / 2;
        self.AgencePic.clipsToBounds = true;
        self.interView.layer.cornerRadius = 5 ;
        
        
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
                    let url =  URL(string: (json["photo"].stringValue))
                    self.nameAgence?.text = name
                    self.emailAgence?.text = email
                    self.addressAgence?.text = address
                    self.phoneAgence?.text = phone
                    self.id?.text = String(describing: json["idAgence"])
                    
                   Alamofire.request(url!).responseImage { response in
                        debugPrint(response)
                        
                        if let image = response.result.value {
                            self.AgencePic?.image = image
                        }
                    }
                    
                    
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


}
