//
//  PlacesDetailVC.swift
//  FindersKeepers
//
//  Created by Harsh Verma on 11/05/23.
//

import UIKit
class PlacesDetailVC: UIViewController {
    
    let place: PlaceAnnotation
    
    lazy var label: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = UIFont.preferredFont(forTextStyle: .title1)
        return lbl
    }()
    
    lazy var Addresslabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        return lbl
    }()
    
    var directionBtn: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Directions", for: .normal)
        return button
    }()
    
    var callBtn: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
    
    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let sv = UIStackView()
        sv.alignment = .leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = UIStackView.spacingUseDefault
        sv.isLayoutMarginsRelativeArrangement = true
        sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        label.text = place.name
        Addresslabel.text = place.address
        sv.addArrangedSubview(label)
        sv.addArrangedSubview(Addresslabel)
        label.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        let contactSV = UIStackView()
        contactSV.translatesAutoresizingMaskIntoConstraints = false
        contactSV.axis = .horizontal
        contactSV.spacing = UIStackView.spacingUseSystem
        
        directionBtn.addTarget(self, action: #selector(getDirection), for: .touchUpInside)
        callBtn.addTarget(self, action: #selector(getCall), for: .touchUpInside)
        contactSV.addArrangedSubview(directionBtn)
        contactSV.addArrangedSubview(callBtn)
        
        
        
        sv.addArrangedSubview(contactSV)
        view.addSubview(sv)
    }
    
    @objc func getDirection(_ sender: UIButton) {
        let coordinate = place.location.coordinate
        guard let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else { return  }
        UIApplication.shared.open(url)
    }
    
    @objc func getCall(_ sender: UIButton) {
        guard let url = URL(string: "tell:// \(place.phone.formatter)") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
