import UIKit

import Kingfisher

class DemoAboutViewController: UIViewController, DemoController {

	var menuController: CariocaController?

	override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var interView: UIView!
    
    @IBOutlet weak var btnProfil: UIButton!
    @IBOutlet weak var blurImg: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBAction func toMap(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.width / 2;
        self.imgUser.clipsToBounds = true;
        self.btnProfil.layer.cornerRadius = 5 ;
        self.interView.layer.cornerRadius = 5;
        
    
        lblName.text = "\(UserDefaults.standard.string(forKey: "firstname") as! String) \(UserDefaults.standard.string(forKey: "lastname") as! String) "
        lblPhone.text = UserDefaults.standard.string(forKey: "phone") as? String
        email.text = UserDefaults.standard.string(forKey: "email") as? String
        lblAddress.text = UserDefaults.standard.string(forKey: "address") as? String
        lblPhone.text = UserDefaults.standard.string(forKey: "phone") as? String
        let url = URL(string: (UserDefaults.standard.string(forKey: "url") as? String)! )
        imgUser.kf.setImage(with: url)
    }
    
}
