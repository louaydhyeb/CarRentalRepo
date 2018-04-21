//
//  RegistrationViewController.swift
//  CariocaMenuDemo
//
//  Created by Admin on 03/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import UIKit
import Alamofire
class RegistrationViewController: UIViewController {

    
    let URLRegsiter = "http://192.168.254.129/Scripts/v1/registerUserIos.php"
    @IBOutlet weak var textUser: UITextField!
    
    @IBOutlet weak var textPass: UITextField!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtLast: UITextField!
    @IBOutlet weak var textMail: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBAction func Reg(_ sender: UIButton) {
        
        let parameters:Parameters=[
            "username":textUser.text!,
            "password":textPass.text!,
            "email":textMail.text!,
            "firstname":txtFirst.text!,
            "lastname":txtLast.text!,
            "phone":txtPhone.text!,
            "address":txtLocation.text!,
            ]
        
        Alamofire.request(URLRegsiter,method: .post, parameters: parameters ).responseJSON{
            
            response in
            print(response)
            
            if let result = response.result.value{
                
                let jsonData = result as! NSDictionary
                
                print(jsonData.value(forKey:"message")as! String? as Any)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
