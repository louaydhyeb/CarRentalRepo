import UIKit
import Alamofire
import AlamofireImage

class DemoSettingsViewController: UIViewController, DemoController,UICollectionViewDataSource,UICollectionViewDelegate {
   
    

	var menuController: CariocaController?
	
   
    // Declaration Array et URL
    let URL_GET_DATA = "http://192.168.254.129/Scripts/v1/selectAllAgence.php"
    var agencies = [Agence]()
    
	override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    @IBOutlet weak var collectionAence: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
	}
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return agencies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! AgenceCollectionViewCell
        
        let agence: Agence
        agence = agencies[indexPath.row]
        
        //displaying values
        cell.lblNameAgence.text = agence.nameAgence
        cell.lblPhoneAgence.text = agence.phoneAgence
        
        Alamofire.request(agence.photoAgence!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.imgAgence.image = image
            }
        }

        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nameA = agencies[indexPath.row].nameAgence
        let vc = AgencyViewController() //your view controller
        vc.stringPassed = nameA!
        
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(URL_GET_DATA,method: .get).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let agenceArray : NSArray  = json as! NSArray
                print(json)
                //traversing through all elements of the array
                for i in 0..<agenceArray.count{
                    
                    //adding hero values to the hero list
                    self.agencies.append(Agence(
                        idAgence: (agenceArray[i] as AnyObject).value(forKey: "AgenceId") as? String,
                        nameAgence: (agenceArray[i] as AnyObject).value(forKey: "AgenceName") as? String,
                        emailAgence: (agenceArray[i] as AnyObject).value(forKey: "AgenceEmail") as? String,
                        phoneAgence: (agenceArray[i] as AnyObject).value(forKey: "AgencePhone") as? String,
                        photoAgence: (agenceArray[i] as AnyObject).value(forKey: "AgencePhoto") as? String
                    ))
                    
                }
                
                //displaying data in tableview
                self.collectionAence.reloadData()
            }
        
    }
    
    
    

    }}
