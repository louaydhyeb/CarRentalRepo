//
//  AppDelegate.swift
//  CariocaMenuDemo
//
//  Created by Arnaud Schloune on 21/11/2017.
//  Copyright © 2017 CariocaMenu. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyAZCSZpVRiJdma2acP7a2KhlSMsQTysTL4")
        
        GMSServices.provideAPIKey("AIzaSyAZCSZpVRiJdma2acP7a2KhlSMsQTysTL4")
        
        return true
    }
    
    
}
