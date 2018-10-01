//
//  ViewController.swift
//  AquiV1
//
//  Created by Tania Barroso López  on 3/12/18.
//  Copyright © 2018 Tania Barroso López. All rights reserved.
//

import UIKit
import SKMaps


class ViewController: UIViewController, SKMapViewDelegate, UIPopoverPresentationControllerDelegate {
    var currentAnotation = Anotacion()
    var markers = [Anotacion]()
    var mapView : SKMapView!
    var random: Int = 200
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
        currentAnotation.coordenate.latitude = locationTap.latitude
        currentAnotation.coordenate.longitude = locationTap.longitude
        
        self.performSegue(withIdentifier: "addMarcador", sender: self)
    }
    
    func addMarcador(_ notification: Notification) -> Void {
        let annotation = SKAnnotation()
        annotation.minZoomLevel = 11
        annotation.offset = CGPoint(x: 0, y: 15 )
        annotation.identifier = Int32(random + markers.count)
        currentAnotation.id = random + markers.count
        random += 1
        annotation.annotationType = SKAnnotationType.blue
        annotation.location = CLLocationCoordinate2DMake(locationTap.latitude , locationTap.longitude)
       
        currentAnotation.nombre = notification.userInfo?["name"] as! String
        
        markers.append(currentAnotation)
        let animationSet = SKAnimationSettings()
        animationSet.animationType = SKAnimationType.animationPinDrop
        
        self.mapView.addAnnotation(annotation, with: animationSet)
       
    }

    func mapView(_ mapView: SKMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if coordinate.latitude != currentAnotation.coordenate.latitude || coordinate.longitude != currentAnotation.coordenate.longitude {
            
            mapView.hideCallout()
        }
    }
    func mapView(_ mapView: SKMapView, didSelect annotation: SKAnnotation) {
        print(markers.count)
        
        for i in 0..<markers.count {
            print(markers[i].id)
            print(markers[i].nombre)
            print(i)
        }
         let annt = markers[annotation.identifier - 201]
        mapView.calloutView.titleLabel.text = annt.nombre
          let behavior = NSDecimalNumberHandler(roundingMode: .plain, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
       
       
        mapView.calloutView.subtitleLabel.text = "".appendingFormat("ltt: %@, lng: %@",  NSDecimalNumber (value: annt.coordenate.latitude).rounding(accordingToBehavior: behavior) , NSDecimalNumber (value: annt.coordenate.longitude).rounding(accordingToBehavior: behavior))
        mapView.showCallout(for: annotation, withOffset: annotation.offset, animated: true)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMarcador"{
            let popoverViewController = segue.destination as! AddMarcadorViewController
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
            
           
        }
        
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}

