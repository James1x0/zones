//
//  ViewController.swift
//  Zones
//
//  Created by James Collins on 2/22/17.
//  Copyright © 2017 James Collins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController:
  UIViewController,
  CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!

    var locationManager: CLLocationManager!

    var userLat: Double = 0
    var userLng: Double = 0
    var didSetMapFrame: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true

        if (CLLocationManager.locationServicesEnabled())
        {
            print("locationServicesEnabled");
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

        print("on viewDidLoad finished")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMapLocation(location: CLLocation) {
        if didSetMapFrame == true {
            return
        }

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        didSetMapFrame = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last

        userLat = location!.coordinate.latitude
        userLng = location!.coordinate.longitude

        updateMapLocation(location: location!)

        print("got LAT: \(location!.coordinate.latitude) LONG: \(location!.coordinate.longitude)")
    }
}

