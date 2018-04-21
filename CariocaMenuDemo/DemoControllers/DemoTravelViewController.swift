import UIKit
import GoogleMaps

class DemoTravelViewController: UIViewController, DemoController {

	var menuController: CariocaController?

	override var preferredStatusBarStyle: UIStatusBarStyle { return .default }

	override func viewWillAppear(_ animated: Bool) {
		self.view.addCariocaGestureHelpers([.left, .right], width: 30.0)
        
	}
    override func viewDidLoad() {
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString("Nour Jaafer") {
            placemarks, error in
            let placemark = placemarks?.first
            
            let camera = GMSCameraPosition.camera(withLatitude: 36.911786, longitude: 10.187836, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.settings.myLocationButton = true
            mapView.isMyLocationEnabled = true
            mapView.delegate = self as? GMSMapViewDelegate
            mapView.settings.zoomGestures = true
            self.view = mapView
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:  36.911786, longitude: 10.187836)
            marker.title = "Nour Jaafer"
            marker.snippet = "Australia"
            marker.map = mapView
        }
    }
}
