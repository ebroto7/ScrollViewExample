//
//  MapViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 19/3/21.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    
    @IBOutlet weak var predetMapTypeButton: UIButton!
    @IBOutlet weak var satelitMapTypeButton: UIButton!
    @IBOutlet weak var relleuMapTypeButton: UIButton!
    
    @IBOutlet weak var ButtonsVisualEffect: UIVisualEffectView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var containerButtonsView: UIView!
    
    @IBOutlet var buttonsContainer: [UIButton]!
    
    @IBAction func buttonGridOptions(_ sender: UIButton) {
        changeViewByButton(tag: sender.tag)
        selectedButton(sender: sender)
        mapView.reloadInputViews()
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    //    let barcelona = CLLocation(latitude: 41.3879, longitude: 2.16992)
    //    var initialLocation: CLLocation = CLLocation(latitude: 41.3879, longitude: 2.16992)
    //    //    Latitud: 41.3879, Longitud: 2.16992 41° 23′
    
    var userCoordinate = [CLLocation]()
    var currentPolyline: MKPolyline? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        
        
        //        selectedButton(sender: predetMapTypeButton)
        //        changeViewByButton(tag: 0)
        
        containerButtonsView.layer.cornerRadius = 10
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            print("se ha aceptado el permiso")
            checkAuthorizationStatus()
            //            mapView.centerToLocation(location ?? barcelona)
            mapView.showsUserLocation = true
            
            
            //            mapView.showsUserLocation = true
            
            locationManager.startUpdatingLocation()
            //            updateLocationOnMap(to: location ?? barcelona, with: "your position")
            //            print("$$ \(locationManager.location)")
            
        
            
        } else {
            print("NO se ha aceptado el permiso")
            
            // Haga algo para que los usuarios sepan por qué necesitan activarlo.
        }
        
        
        
    }
    
    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied: break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .restricted:
            break
        case .authorizedAlways:
            break
            
        @unknown default:
            break
        }
        
        
        
    }
    
    
    func changeViewByButton(tag: Int)  {
        switch tag {
        case 0 :
            print("1r - botó")
            mapView.mapType = MKMapType.standard
            
        case 1:
            print("2n - botó")
            mapView.mapType = MKMapType.satellite
            
        case 2:
            print("3r - botó")
            mapView.mapType = MKMapType.hybrid
        default:
            print("Warning! El tag \(tag) no esta controlat.")
        }
        mapView.reloadInputViews()
    }
    func selectedButton(sender: UIButton) {
        for button in buttonsContainer {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    func updatePolyline() {
        
        var userCoordinates2D: [CLLocationCoordinate2D] = []
        
        for location in userCoordinate {                    // aixó es pot fer amb la funció .map
            userCoordinates2D.append(location.coordinate)
        }
        let coordinates: [CLLocationCoordinate2D] = userCoordinates2D
        //         let coordinates: [CLLocationCoordinate2D] = userCoordinate.map{ $0.coordinate}
        
        
        let newPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        mapView.addOverlay(newPolyline)
        
        if let polyLine = currentPolyline {
        mapView.removeOverlay(polyLine)
        }
        currentPolyline = newPolyline
        
    }
    
    
    //para poner marcador de una localización en el mapa
    //    func updateLocationOnMap(to location: CLLocation, with title: String?) {
    //
    //          let point = MKPointAnnotation()
    //          point.title = title
    //          point.coordinate = location.coordinate
    //          self.mapView.removeAnnotations(self.mapView.annotations)
    //          self.mapView.addAnnotation(point)
    //
    //          let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
    //          self.mapView.setRegion(viewRegion, animated: true)
    //      }
    //
    
}



extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        
        userCoordinate.append(location)
        
        updatePolyline()
        
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {   //si no implemento aquesta funció em dibuixa un linea amb valors per defecte
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            //confugura un linea amb les següents característiques
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.8)     //dona color a la linea i la fa un mica transparent(alpha)
            renderer.lineWidth = 7          //dona gruix a la linea
            return renderer
        }
        return MKOverlayRenderer()
        
    }
}
