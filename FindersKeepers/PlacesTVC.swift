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
    
    var location: CLLocation
    var places: [PlaceAnnotation]
    
    
    var indexselectionRow: Int? {
        self.places.firstIndex(where: {$0.isSelected == true})
    }
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.places = places
        self.location = userLocation
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "place")
        self.places.swapAt(indexselectionRow ?? 0, 0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func calculateDistance(from: CLLocation, to: CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    
    func formatDistanceData(_ distance: CLLocationDistance) -> String {
        let km = Measurement(value: distance, unit: UnitLength.kilometers)
        return km.converted(to: .kilometers).formatted()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = places[indexPath.row].name
        content.secondaryText = formatDistanceData(calculateDistance(from: location, to: places[indexPath.row].location))
        cell.contentConfiguration = content
        cell.backgroundColor = places[indexPath.row].isSelected ? UIColor.lightGray : UIColor.cyan
        return cell
    }
}
