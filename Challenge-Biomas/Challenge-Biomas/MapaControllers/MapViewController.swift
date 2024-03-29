//
//  ViewController.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/11/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let artworks = LoadGeoJson().artworks
    let estateartworks = LoadGeoJson().estateartworks
    let brasil = Brasil(filename: "BrasilCoord")
    let mapView = MKMapView()
    var tipo: Tipo = .bioma
    static var b: Int = -1
    var biomas: Biomas = .amazonia
    
    
    
    
    // Declara os botoes como propriedades lazy var antes do viewdidload
    lazy var buttonsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    //Botão de Informação
    lazy var infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.tintColor = UIColor(named: "mygreen")
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.layer.borderWidth = 0.25
        button.addTarget(self, action: #selector(buttonActionInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = UIColor(named: "mygreen")
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.layer.borderWidth = 0.25
        button.addTarget(self, action: #selector(buttonActionArrow), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        view.addSubview(mapView)
        setupButtons()
        mapView.delegate = self
        
        addBiomaBoundary()
        mapView.addAnnotations(artworks)
        
        // retorna o valor selecionado na segmented
        guard let selectedIndex = UserDefaults.standard.value(forKey: "MapSelectedIndex") as? Int else {
            return // selected index n tinha nada
        }
        
        switch selectedIndex {
        case 0:
            self.tipo = .bioma // se for 0, tipo do mapa é bioma
            mapView.removeOverlays(mapView.overlays)
            mapView.removeAnnotations(estateartworks)
            addBiomaBoundary()
            mapView.addAnnotations(artworks)
            break
        case 1:
            self.tipo = .estados // se o 1 tipo do mapa for estado
            mapView.removeOverlays(mapView.overlays)
            addEstadoBoundary()
            mapView.removeAnnotations(artworks)
            mapView.addAnnotations(estateartworks)
            break
        default:
            break
        }
  
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func setupButtons() {
        self.view.addSubview(buttonsBackgroundView)
        self.buttonsBackgroundView.addSubview(infoButton)
        self.buttonsBackgroundView.addSubview(arrowButton)
        self.buttonsBackgroundView.clipsToBounds = true
        
        self.buttonsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.arrowButton.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    //funçao que cria a aba do ponto de interesse
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        
        let customAnnotation: MKAnnotation
        
        if tipo == .bioma {
            customAnnotation = annotation as! Artwork
        } else {
            customAnnotation = annotation as! EstateArtwork
        }
        
        // 3
        let identifier = "artwork"
        var view: MKMarkerAnnotationView
        
        view = MKMarkerAnnotationView(
            annotation: customAnnotation,
            reuseIdentifier: identifier)
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView?.tintColor = UIColor(named: "mygreen")
        return view
    }
    
    //Função de click
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if tipo == .bioma {
            guard let artwork = view.annotation as? Artwork else {
                return
            }
            MapViewController.b = artwork.number ?? -1
            let vc = InfoBiomaViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            guard let estateArtwork = view.annotation as? EstateArtwork else{
                return
            }
            MapViewController.b = estateArtwork.number ?? -1
            let vc = InfoDesmatamentoViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    //Gera polígono
    func mapView(_ map: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            
            if tipo == .bioma {
                
                switch biomas  {
                case .amazonia:
                    polygonView.fillColor = UIColor(red: 0.0196, green: 0.447, blue: 0.0039, alpha: 1)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .pampa:
                    polygonView.fillColor = UIColor(red: 0.011, green: 0.105, blue: 0.996, alpha: 0.5)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .pantanal:
                    polygonView.fillColor = UIColor(red: 0.976, green: 0.756, blue: 0.341, alpha: 1)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .caatinga:
                    polygonView.fillColor = UIColor(red: 0.949, green: 0.729, blue: 0.674, alpha: 1)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .cerrado:
                    polygonView.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .mataAtlantica:
                    polygonView.fillColor = UIColor(red: 0.478, green: 0.384, blue: 0.286, alpha: 1)
                    polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                }
                
                return polygonView
            } else {
                polygonView.fillColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                polygonView.strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                
                return polygonView
            }
            
        }
        
        return MKOverlayRenderer()
    }
    //
    //    Adiciona o overlay para a addBoundary
    func addOverlay() {
        let overlay = BrasilMapOverlay(brasil: brasil)
        mapView.addOverlay(overlay)
    }
    
    
    //Adiciona as coordenadas onde o será feita a marcação de biomas
    func addBiomaBoundary() {
        while biomas == .amazonia {
            mapView.addOverlay(MKPolygon(coordinates: brasil.Amazonia, count: brasil.Amazonia.count))
            biomas = .pampa
        }
        while biomas == .pampa {
            mapView.addOverlay(MKPolygon(coordinates: brasil.Pampa, count: brasil.Pampa.count))
            biomas = .pantanal
        }
        while biomas == .pantanal {
            mapView.addOverlay(MKPolygon(coordinates: brasil.Pantanal, count: brasil.Pantanal.count))
            biomas = .caatinga
        }
        while biomas == .caatinga {
            mapView.addOverlay(MKPolygon(coordinates: brasil.Caatinga, count: brasil.Caatinga.count))
            biomas = .cerrado
        }
        while biomas == .cerrado {
            mapView.addOverlay(MKPolygon(coordinates: brasil.Cerrado, count: brasil.Cerrado.count))
            biomas = .mataAtlantica
        }
        while biomas == .mataAtlantica {
            mapView.addOverlay(MKPolygon(coordinates: brasil.MataAtlantica, count: brasil.MataAtlantica.count))
            biomas = .amazonia
        }
    }
    
    
    //Adiciona as coordenadas onde será feita a marcações de estado
    func addEstadoBoundary() {
        //        mapView.addOverlay(MKPolygon(coordinates: brasil.Amazonas, count: brasil.Amazonas.count))
    }
    
    
    //Button que muda o filtro por enquanto
    @objc func buttonActionArrow(sender: UIButton!) {
        print("Clicked")
        
    }
    
    
    @objc func buttonActionInfo(sender: UIButton!) {
        print("Clicked")
        let vc = LegendasViewController(delegate: self)
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}

extension MapViewController: LegendasViewDelegate {
    func exibir(_ tipo: Tipo) {
        
        self.tipo = tipo
        
        switch tipo {
        case .bioma:
            
            mapView.removeOverlays(mapView.overlays)
            mapView.removeAnnotations(estateartworks)
            addBiomaBoundary()
            mapView.addAnnotations(artworks)
            
            
        case .estados:
            
            mapView.removeOverlays(mapView.overlays)
            addEstadoBoundary()
            mapView.removeAnnotations(artworks)
            mapView.addAnnotations(estateartworks)
        }
    }
}

//Protocolo que passa o tipo a ser exibido
protocol LegendasViewDelegate: class {
    func exibir(_ tipo: Tipo)
}


enum Tipo {
    case bioma
    case estados
}

enum Biomas {
    case amazonia
    case pampa
    case pantanal
    case caatinga
    case cerrado
    case mataAtlantica
}

