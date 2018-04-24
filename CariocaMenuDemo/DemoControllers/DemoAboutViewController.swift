import UIKit

import Kingfisher

class DemoAboutViewController: UIViewController, DemoController {

	var menuController: CariocaController?

	override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBAction func toMap(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = UserDefaults.standard.string(forKey: "firstname") as? String
        lblPhone.text = UserDefaults.standard.string(forKey: "phone") as? String
        email.text = UserDefaults.standard.string(forKey: "email") as? String
        lblAddress.text = UserDefaults.standard.string(forKey: "address") as? String
        lblPhone.text = UserDefaults.standard.string(forKey: "phone") as? String
        let url = URL(string: (UserDefaults.standard.string(forKey: "url") as? String)! )
        imgUser.kf.setImage(with: url)
    }
    
   
}
