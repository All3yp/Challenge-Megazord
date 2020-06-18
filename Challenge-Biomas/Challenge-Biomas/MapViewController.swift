//
//  ViewController.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/11/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private var artworks: [Artwork] = []
    private var estateartworks: [EstateArtwork] = []
    let brasil = Brasil(filename: "BrasilCoord")
    let mapView = MKMapView()
    var filtro = true
    
//    Função que carrega o geojson ao iniciar o aplicativo
    private func loadInitialData() {
      // 1
      guard
        let fileName = Bundle.main.url(forResource: "BioPoints", withExtension: "geojson")

        else {
          return
      }

      do {
        // 2
        let artworkData = try Data(contentsOf: fileName)
        let features = try MKGeoJSONDecoder()
          .decode(artworkData)
          .compactMap { $0 as? MKGeoJSONFeature }
        // 3
        let validWorks = features.compactMap(Artwork.init)
        // 4
        artworks.append(contentsOf: validWorks)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }
    
//    private func loadInitialDataEstate() {
//      // 1
//      guard
//        let fileName = Bundle.main.url(forResource: "EstatePoints", withExtension: "geojson")
//
//        else {
//          return
//      }
//
//      do {
//        // 2
//        let artworkData = try Data(contentsOf: fileName)
//        let features = try MKGeoJSONDecoder()
//          .decode(artworkData)
//          .compactMap { $0 as? MKGeoJSONFeature }
//        // 3
//        let validWorks2 = features.compactMap(EstateArtwork.init)
//        // 4
//        estateartworks.append(contentsOf: validWorks2)
//      } catch {
//        // 5
//        print("Unexpected error: \(error).")
//      }
//    }

    
    
    
    // Declara os botoes como propriedades lazy var antes do viewdidload
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
        button.addTarget(self, action: #selector(buttonActionInfo), for: .touchUpInside)
        return button
    }()

    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = UIColor(named: "tintButton")
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.layer.borderWidth = 0.25
        button.addTarget(self, action: #selector(buttonActionArrow), for: .touchUpInside)
        return button
    }()
    
    //Ativa e desativa a overlay de bioma ou estado
    var displayOverlay: Bool = true {
        didSet(value) {
            switch value {
            case true:
                mapView.removeOverlays(mapView.overlays)
//                mapView.removeAnnotations(estateartworks)
                addBiomaBoundary()
                mapView.addAnnotations(artworks)
            case false:
                mapView.removeAnnotations(artworks)
                mapView.removeOverlays(mapView.overlays)
                addEstadoBoundary()
//                mapView.addAnnotations(estateartworks)
            }
        }
    }
    
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
        loadInitialData()
//        loadInitialDataEstate()
        
        

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
    
    //funçao que cria o ponto de interesse 
 func mapView(
      _ mapView: MKMapView,
      viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
      // 2
      guard let annotation = annotation as? Artwork else {
        return nil
      }
      // 3
      let identifier = "artwork"
      var view: MKMarkerAnnotationView
      // 4
      if let dequeuedView = mapView.dequeueReusableAnnotationView(
        withIdentifier: identifier) as? MKMarkerAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        // 5
        view = MKMarkerAnnotationView(
          annotation: annotation,
          reuseIdentifier: identifier)
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      }
      return view
    }
    
//     func mapView2(
//         _ mapView: MKMapView,
//         viewFor annotation: MKAnnotation
//       ) -> MKAnnotationView? {
//         // 2
//           guard let annotation = annotation as? EstateArtwork else {
//               return nil
//           }
//
//         // 3
//           let identifier = "estateartwork"
//           var view2: MKMarkerAnnotationView
//
//         // 4
//           if let dequeuedView = mapView.dequeueReusableAnnotationView(
//               withIdentifier: identifier) as? MKMarkerAnnotationView {
//               dequeuedView.annotation = annotation
//               view2 = dequeuedView
//           } else {
//           // 5
//               view2 = MKMarkerAnnotationView(
//                   annotation: annotation,
//                   reuseIdentifier: identifier)
//               view2.canShowCallout = true //Gera a caixa de mensagem
//               view2.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) // Gera o botão de Info dentro da caixa de mensagem
//         }
//         return view2
//       }
    
    //Função de click
    func mapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let artwork = view.annotation as? Artwork else {
        return
      }

      let launchOptions = [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
      ]
      artwork.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
     //Gera o polígono
    func mapView(_ map: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.fillColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
            polygonView.strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            
            return polygonView
        }

         return MKOverlayRenderer()
    }
    
    //Adiciona o overlay para a addBoundary
    func addOverlay() {
        let overlay = BrasilMapOverlay(brasil: brasil)
        mapView.addOverlay(overlay)
    }

    //Adiciona as coordenadas onde o será feita a marcação de biomas
    func addBiomaBoundary() {
        mapView.addOverlay(MKPolygon(coordinates: brasil.Caatinga, count: brasil.Caatinga.count))
        mapView.addOverlay(MKPolygon(coordinates: brasil.Pampa, count: brasil.Pampa.count))
        mapView.addOverlay(MKPolygon(coordinates: brasil.MataAtlantica, count: brasil.MataAtlantica.count))
        mapView.addOverlay(MKPolygon(coordinates: brasil.Pantanal, count: brasil.Pantanal.count))
        mapView.addOverlay(MKPolygon(coordinates: brasil.Cerrado, count: brasil.Cerrado.count))
        mapView.addOverlay(MKPolygon(coordinates: brasil.Amazonia, count: brasil.Amazonia.count))
    }
    //Adiciona as coordenadas onde será feita a marcações de estado
    func addEstadoBoundary() {
        mapView.addOverlay(MKPolygon(coordinates: brasil.Nordeste, count: brasil.Nordeste.count))
    }
    
    //Button que muda o filtro por enquanto
    @objc func buttonActionArrow(sender: UIButton!) {
        displayOverlay.toggle()
        print("Clicked")

    }
    

    @objc func buttonActionInfo(sender: UIButton!) {
        print("Clicked")
        let vc = LegendasViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)

    }

}
