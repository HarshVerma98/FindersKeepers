//
//  ViewController.swift
//  FindersKeepers
//
//  Created by Harsh Verma on 10/05/23.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    
    var locationManager: CLLocationManager?
    
    lazy var mapView: MKMapView = {
       let mp = MKMapView()
        mp.showsUserLocation = true
        mp.translatesAutoresizingMaskIntoConstraints = false
        return mp
    }()
    
    lazy var searchText: UITextField = {
       let st = UITextField()
        st.layer.cornerRadius = 10
        st.clipsToBounds = true
        st.backgroundColor = UIColor.white
        st.placeholder = "Search"
        st.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        st.leftViewMode = .always
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization() // till using
        locationManager?.requestLocation()
        locationManager?.requestAlwaysAuthorization()
    }

    func setupUI() {
        view.addSubview(mapView)
        view.addSubview(searchText)
        view.bringSubviewToFront(searchText)
        
        
        searchText.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchText.widthAnchor.constraint(equalToConstant: view.bounds.size.width/1.2).isActive = true
        searchText.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchText.returnKeyType = .go
        
        
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
