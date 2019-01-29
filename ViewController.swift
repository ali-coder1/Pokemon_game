//
//  ViewController.swift
//  Pockemon
//
//  Created by Ali Alshahrani on 1/2/19.
//  Copyright © 2019 Ali Alshahrani. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    var mapView:GMSMapView!
    var listPockemons:Array = [pockemon]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPockemons()
        
        // camera position is the eye position on the map that should be at your location
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 20)
        // set the map on the view
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        // get user location
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        }
    }
    
    // set variable to have my location by Coordinate
    var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocation = manager.location!.coordinate // update to get my current location
        self.mapView.clear()

        // To show my location visible on the map
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        markerMe.title = "Me"
        markerMe.snippet = "Here is my location"
        markerMe.icon = UIImage(named: "mario")
        markerMe.map = self.mapView // link it with the view
        
        // To show other Pockemons visible on the map
        var index = 0
        for pockemon in listPockemons {
        
        if pockemon.isCatched == false {
            let markerPockemon = GMSMarker()
            markerPockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitiude!, longitude: pockemon.longitude!)
            markerPockemon.title = pockemon.name!
            markerPockemon.snippet = "\(pockemon.des!) - Power \(pockemon.power!)"
            markerPockemon.icon = UIImage(named: pockemon.image!)
            markerPockemon.map = self.mapView
            
        // Here to Catch the Pockemon
        if (Double(myLocation.latitude).roundTo(places: 4) == Double(pockemon.latitiude!).roundTo(places: 4))
        && (Double(myLocation.longitude).roundTo(places: 4) == Double(pockemon.longitude!).roundTo(places: 4)) {
            
            listPockemons[index].isCatched = true
            alertMsg(pockemonPower: pockemon.power!)
                
        }

        }
            index = index + 1
            
        }
        
        // camera position is the eye position on the map that should be at your location
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        self.mapView.camera = camera
        
    }
    
    var playerPower:Double = 0.0
    // info about Pockemons that I did inside pockemon.swift class
    func loadPockemons() {
        
        self.listPockemons.append(pockemon(latitiude: 21.768433304300325, longitude: 39.1743204792209, image: "bulbasaur", name: "Bulbasaur", des: "He is living in the oceans", power: 44, isCatched: false))
        
        self.listPockemons.append(pockemon(latitiude: 21.798433304300325, longitude: 39.1843204792209, image: "charmander", name: "Charmander", des: "He is living in the deserts", power: 66, isCatched: false))
        
        self.listPockemons.append(pockemon(latitiude: 21.788433304300325, longitude: 39.1943204792209, image: "squirtle", name: "Squirtle", des: "He is living in the jungles", power: 88, isCatched: false))
    }
    
    // Alert message set up
    func alertMsg(pockemonPower:Double) {
      playerPower = playerPower + pockemonPower
        let alert = UIAlertController(title: "Catch a new pockemon", message: "Your new power is \(playerPower)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in print("Add one")}))
        self.present(alert, animated: true, completion: nil)
    }


}
// Here OUTSIDE class ViewController
// To set up the Double Number to be as specific spots of Numbers after (.) Dot
extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

