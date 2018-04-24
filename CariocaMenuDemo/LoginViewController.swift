//
//  LoginViewController.swift
//  CariocaMenuDemo
//
//  Created by Admin on 03/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    let URLLogin = "http://192.168.254.129/Scripts/v1/userLogin.php"
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textPass: UITextField!
    
    
    @IBAction func login(_ sender: UIButton) {
        
        let parameters:Parameters=[
            "username":textUser.text!,
            "password":textPass.text!,
            ]
        Alamofire.request(URLLogin, method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["error"] == false{
                    print("logged in")
                    let id = String(describing: json["firstname"])
                    let a = String(describing: json["lastname"])
                    let b = String(describing: json["id"])
                    let c = String(describing: json["email"])
                    let d = String(describing: json["url"])
                    let e = String(describing: json["address"])
                    let ph = String(describing: json["phone"])
                    let url = String(describing: json["url"])
                    let username = String(describing: json["username"])
                    
                    
                    var defaults = UserDefaults.standard
                    defaults.set(id,     forKey: "firstname")
                    defaults.set(ph,     forKey: "phone")
                    defaults.set(c,     forKey: "email")
                    defaults.set(d,     forKey: "photo")
                    defaults.set(e,     forKey: "address")
                    defaults.set(a,     forKey: "lastname")
                    defaults.set(b,     forKey: "id")
                    defaults.set(username,     forKey: "username")
                    defaults.set(url,     forKey: "url")
                    self.performSegue(withIdentifier: "toMenu", sender: nil)
                } else if json["error"] == true {
                    print("not loggedin")
                    let message = "wrong password "
                    let alert = UIAlertController(title: "Wrong", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                print("JSON: \(json)")
                let message = "wrong email "
                let alert2 = UIAlertController(title: "Wrong", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert2.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
            case .failure(let error):
                print(error)
                let message = "cannot reach server "
                let alert2 = UIAlertController(title: "error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert2.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        
        if(preferences.string(forKey: "username") != nil)
        {
            self.performSegue(withIdentifier: "toMenu", sender: nil)
            print("T3adit")
        }
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
