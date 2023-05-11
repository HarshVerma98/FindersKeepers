//
//  PlacesTVC.swift
//  FindersKeepers
//
//  Created by Harsh Verma on 11/05/23.
//

import UIKit
import CoreLocation
import MapKit
class PlacesTVC: UITableViewController {
    
    var location: CLLocation?
    let places: [PlaceAnnotation]
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.places = places
        self.location = userLocation
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "place")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = places[indexPath.row].name
        content.secondaryText = "Something"
        cell.contentConfiguration = content
        return cell
    }
}
