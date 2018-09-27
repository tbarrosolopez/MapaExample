//
//  ViewController.swift
//  AquiV1
//
//  Created by Tania Barroso López  on 3/12/18.
//  Copyright © 2018 Tania Barroso López. All rights reserved.
//

import UIKit
import SKMaps

class ViewController: UIViewController, SKMapViewDelegate {
    var currentAnotation = Anotacion()
    var mapView : SKMapView!
    var locationTap = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        let initSettings = SKMapsInitSettings()
        initSettings.mapDetailLevel = SKMapDetailLevel.light
        SKMapsService.sharedInstance().initializeSKMaps(withAPIKey: "API_KEY", settings: initSettings)
       
        self.mapView = SKMapView(frame: self.view.frame)
        self.mapView.delegate = self
        self.mapView.settings.showCompass =  true
        self.mapView.settings.showAccuracyCircle = true
        self.mapView.animate(toZoomLevel: 11)
        self.mapView.visibleRegion = SKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.1349041743746, longitude: -82.3676776885986), zoomLevel: 11)
        self.view.addSubview(self.mapView)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.addMarcador(_:)), name: NSNotification.Name(rawValue: "addMarcador"), object: nil)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: SKMapView, didLongTapAt coordinate: CLLocationCoordinate2D) {
        locationTap = coordinate
        print(locationTap.latitude)
        print(locationTap.longitude)
        self.performSegue(withIdentifier: "addMarcador", sender: self)
    }
    
    func addMarcador(_ notification: Notification) -> Void {
        let annotation = SKAnnotation()
        annotation.minZoomLevel = 11
        annotation.offset = CGPoint(x: 0, y: 15 )
        annotation.identifier = Int32(300)
        annotation.annotationType = SKAnnotationType.blue
        annotation.location = CLLocationCoordinate2DMake(locationTap.latitude , locationTap.longitude)
        currentAnotation.coordenate = locationTap
        currentAnotation.nombre = notification.userInfo?["name"] as! String
        let animationSet = SKAnimationSettings()
        animationSet.animationType = SKAnimationType.animationPinDrop
        
        self.mapView.addAnnotation(annotation, with: animationSet)
       
    }

    func mapView(_ mapView: SKMapView, didSelect annotation: SKAnnotation) {
        
        mapView.showCallout(for: annotation, withOffset: annotation.offset, animated: true)
    }
   
    
    

}

