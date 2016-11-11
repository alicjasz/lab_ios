//
//  ViewController.swift
//  Map
//
//  Created by alicja on 11/6/16.
//  Copyright © 2016 alicja. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    var myLocation: CLLocationManager!
    
    @IBAction func startButtonClicked(sender: UIButton) {
        startButton.enabled = false
        stopButton.enabled = true
        myLocation.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    @IBAction func stopButtonClicked(sender: UIButton) {
        myLocation.stopUpdatingLocation()
        mapView.showsUserLocation = false
        stopButton.enabled = false
        startButton.enabled = true
    }
    @IBAction func clearButtonClicked(sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.enabled = false
        
        if (CLLocationManager.locationServicesEnabled()) {
            myLocation = CLLocationManager()
            myLocation.delegate = self
            //myLocation.requestWhenInUseAuthorization()
        }
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            myLocation.requestWhenInUseAuthorization()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        
        let lastLocation = locations[locations.count - 1] as CLLocation
        let center = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude:lastLocation.coordinate.longitude)
        let pointer = MKPointAnnotation()
        pointer.coordinate = center
        mapView.addAnnotation(pointer)
        
        var spanDelta = 0.0
        if let speed = locations.last?.speed where speed > 0 {
            spanDelta = speed / 3000
        }
        let locationArea = MKCoordinateRegionMake(center, MKCoordinateSpanMake(spanDelta, spanDelta))
        mapView.setRegion(locationArea, animated: true)
    }

}

