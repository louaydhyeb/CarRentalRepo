import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class DemoTravelViewController: UIViewController, DemoController, GMSMapViewDelegate {
        let URL_GET_TEAMS:String = "http://192.168.254.129/Scripts/v1/showAddress.php"
        var menuController: CariocaController?
        
        override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
        
        override func viewWillAppear(_ animated: Bool) {
            self.view.addCariocaGestureHelpers([.left, .right], width: 30.0)
            
        }
        override func viewDidLoad() {
             super.viewDidLoad()
            
            
        }
        override func loadView() {
            
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.isMyLocationEnabled = true
            view = mapView
            Alamofire.request(URL_GET_TEAMS, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    for i in 0..<json.count {
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: json[i]["AgenceLat"].doubleValue, longitude: json[i]["AgenceLong"].doubleValue)
                        marker.title =  json[i]["AgenceName"].stringValue
                        marker.snippet = "Australia"
                        marker.map = mapView
                    }
                    
                    
                    
                case .failure(let error):
                    print(error)
                    let message = "cannot reach server "
                    let alert2 = UIAlertController(title: "error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert2.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert2, animated: true, completion: nil)
                }
            }
     
    }
    
}
