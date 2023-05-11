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
    var places: [PlaceAnnotation] = []
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
        st.delegate = self
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
        mapView.delegate = self
        
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
    
    // MARK: - Permission defined function
    
    func checkLocAuth() {
        guard let locMgr = locationManager, let loc = locationManager?.location else {return}
        
        switch locMgr.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("")
            let region = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
        case .denied:
            print("")
        case .notDetermined, .restricted:
            print("")
        @unknown default:
            print("")
            
        }
    }
    
    // MARK: - Search Function
    
    func findNearby(by query: String) {
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] resp, fault in
            guard let value = resp, fault == nil else {
                return
            }
            self?.places = value.mapItems.map(PlaceAnnotation.init)
            print(value.mapItems)
            self?.places.forEach({ plc in
                self?.mapView.addAnnotation(plc)
            })
            self?.popVC(place: self!.places)
        }
    }
    
    // MARK: - VC Method
    func popVC(place: [PlaceAnnotation]) {
       guard let uLocation = locationManager?.location else {
            return
        }
        let vc = PlacesTVC(userLocation: uLocation, places: place)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            present(vc, animated: true)
        }
    }
    
    func clearAnnotationSelection() {
        self.places = self.places.map({ place in
            place.isSelected = false
            return place
        })
    }

}

// MARK: - Location Extensions
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        checkLocAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
}

// MARK: - TextField Extensions

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder()
            // Find nearby places
            
            findNearby(by: text)
        }
        return true
    }
}

// MARK: - MAPKit Delegate

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        clearAnnotationSelection() 
        guard let selectedAnnotation = annotation as? PlaceAnnotation else {
            return
        }
       let placeAnnotation = self.places.first(where: {$0.id == selectedAnnotation.id})
        placeAnnotation?.isSelected = true
        popVC(place: places)
    }
}
