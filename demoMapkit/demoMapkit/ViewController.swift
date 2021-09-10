//
//  ViewController.swift
//  demoMapkit
//
//  Created by MACBOOK PRO on 10/09/2021.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate{

    @IBOutlet weak var mapSample: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // toa do
        let initLocation = CLLocation(latitude: 21.029263, longitude: 105.807865)
        // hien thi trong ban kinh = 1000
        let regioRadius: CLLocationDistance = 1000
        
        func centerMapLocation (location: CLLocation){
            let coordinate = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regioRadius * 2, longitudinalMeters: regioRadius * 2.0)
            mapSample.setRegion(coordinate, animated: true)
        }
        centerMapLocation(location: initLocation)
        
        // khoi tao 1 annotation
        
        let annotationSample = MKPointAnnotation()
        annotationSample.coordinate = initLocation.coordinate
        annotationSample.title = "I'm here!"
        annotationSample.subtitle = "Come with me."
        mapSample.addAnnotation(annotationSample)
        
        // khi nhan vao ban do thi tao ra 1 annotation
        let actionTap = UITapGestureRecognizer(target: self, action: "actionTap:")
        self.mapSample.addGestureRecognizer(actionTap)
        
    }
    
    func actionTap(gestureRecognizer: UITapGestureRecognizer){
        // get location touch point
        let touchPoint = gestureRecognizer.location(in: self.mapSample)
        // tao 1 cooordinate de hung toa do cua touchPoint
        
        let newCoordinate: CLLocationCoordinate2D = mapSample.convert(touchPoint,toCoordinateFrom: self.mapSample)
        
        let annotationSample = MKPointAnnotation()
        annotationSample.coordinate = newCoordinate
        annotationSample.title = "I'm here!"
        annotationSample.subtitle = "Come with me."
        mapSample.addAnnotation(annotationSample)
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
    }


}

