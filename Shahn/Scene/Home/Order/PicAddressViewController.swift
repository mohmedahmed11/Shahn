//
//  PicAddressViewController.swift
//  Salooni
//
//  Created by MOHAMMED on 20/04/2021.
//  Copyright © 2021 Pita Studio. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation

protocol PicLocation {
   
    func picAdd(location: CLLocationCoordinate2D)
}

class PicAddressViewController: UIViewController ,MKMapViewDelegate {
    
//    @IBOutlet weak var myMap: MKMapView!
    
    var googleMapsView:GMSMapView!
    
    @IBOutlet weak var mapPlaceView: UIView!
    var mapView:GMSMapView!
    
    var selectedCordenate:CLLocationCoordinate2D!

    let locationManager = CLLocationManager()
    var previosLocation:CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 0.0)!, longitude: CLLocationDegrees(exactly: 0.0)!)
        ///////////// map view ////////////
    
    var delegate: PicLocation?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        ////////////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationService()
    }
        
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func checkLocationService() {
        setupLocationManager()
        checkLocationAuthrization()
        
    }
    
    
    func  centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            previosLocation = locationManager.location!
            
           setMapView(center: location)
        }else {
            let location = CLLocationCoordinate2D(latitude: 23.885942, longitude: 45.079161)
            setMapView(center: location)
        }
    }
    
    func centerViewOnUserTabedLocation(location : CLLocationCoordinate2D) {
        setMapView(center: location)
    }
    
    
    func notPermitedAlert()  {
        let alertController = UIAlertController(title: "No Permission", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                 }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func checkLocationAuthrization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.stopUpdatingLocation()
        case .denied, .restricted :
            notPermitedAlert()
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func setMapView(center: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: mapPlaceView.frame, camera: camera)
        mapView.frame.origin.y = 0
        mapView.frame.origin.x = 0
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapPlaceView.addSubview(mapView)
        selectedCordenate = center
        
    }

    func gitCenterLocation(for mapView:MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func Piclocation(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        delegate?.picAdd(location: selectedCordenate)
        self.dismiss(animated: true) {
        }
        
    }
    
    @IBAction func back0() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
        
}

extension PicAddressViewController: CLLocationManagerDelegate, GMSMapViewDelegate{
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            locationManager.requestWhenInUseAuthorization()
        }
        checkLocationAuthrization()
    }
        
        
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = gitCenterLocation(for: mapView)
        
        
        guard center.distance(from: previosLocation) > 50 else { return }
        
        previosLocation = center
        selectedCordenate = center.coordinate
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        self.centerViewOnUserTabedLocation(location: coordinate)
        self.selectedCordenate = coordinate
           
    }
}
