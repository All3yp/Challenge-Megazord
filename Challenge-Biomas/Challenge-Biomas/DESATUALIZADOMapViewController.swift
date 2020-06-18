//
//  ViewController.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/11/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.


import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    
    // declara os botoes como propriedades lazy var antes do viewdidload
    lazy var buttonsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.tintColor = UIColor(named: "tintButton")
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.layer.borderWidth = 0.25
        return button
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = UIColor(named: "tintButton")
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.layer.borderWidth = 0.25
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create mapview and constraints
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        
        mapView.center = view.center
        
        view.addSubview(mapView)
        
        //        // Create button map
        //        let button = UIButton(type: .infoLight)
        //        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        //        button.backgroundColor = UIColor.systemBackground
        //        button.layer.cornerRadius = 10
        //        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //        self.view.addSubview(button)
        //
        //    }
        //
        //    @objc func buttonAction(sender: UIButton!) {
        //        print("Clicked")
        //    }
        
        setupButtons()

    }
    
    func setupButtons() {
        self.view.addSubview(buttonsBackgroundView)
        self.buttonsBackgroundView.addSubview(infoButton)
        self.buttonsBackgroundView.addSubview(arrowButton)
        self.buttonsBackgroundView.clipsToBounds = true
        
        self.buttonsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.arrowButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoButton.addTarget(self, action: #selector(merda(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.infoButton.widthAnchor.constraint(equalToConstant: 50),
            self.infoButton.heightAnchor.constraint(equalToConstant: 50),
            self.infoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.infoButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            
            self.arrowButton.widthAnchor.constraint(equalToConstant: 50),
            self.arrowButton.heightAnchor.constraint(equalToConstant: 50),
            self.arrowButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.arrowButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            
            self.buttonsBackgroundView.widthAnchor.constraint(equalToConstant: 50),
            self.buttonsBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            self.buttonsBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.buttonsBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func merda(_ sender: UIButton) {
        let vc = LegendasViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    
}
