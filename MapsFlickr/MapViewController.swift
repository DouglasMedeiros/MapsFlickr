//
//  MapViewController.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    static var startedUserLocation = false

    var mapView: MKMapView!
    var locationManager: CLLocationManager!

    private var userLocation: CLLocationCoordinate2D!
    private var selectecAnnotation: PhotoAnnotation!

    private var mapsAnnotations: [PhotoAnnotation]! {
        didSet {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(self.mapsAnnotations)
        }
    }

    init() {
        self.mapView = MKMapView()
        self.locationManager = CLLocationManager()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.checkLocationAuthorizationStatus()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    private func setupView() {
        self.mapView.mapType = .Standard
        self.mapView.frame = view.frame
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)

        self.locationManager.delegate = self
    }
}

extension MapViewController {

    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    // MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedAlways || status == .AuthorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        } else if (status == .Restricted) {
            let alertController = UIAlertController(title: "Ops!", message: "Erro ao tentar obter a sua localização", preferredStyle: .Alert)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if (status == .Denied) {
            let alertController = UIAlertController(title: "Ops!", message: "Acesso a localização negado!", preferredStyle: .Alert)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard locations.count > 0 else {
            return
        }

        self.locationManager.stopUpdatingLocation()

        self.userLocation = locations.last?.coordinate

        self.mapView.setCenterCoordinate(self.userLocation, animated: true)

        if (!MapViewController.startedUserLocation) {
            MapViewController.startedUserLocation = true
            self.mapView.showsUserLocation = false
            self.mapView.userTrackingMode = .None

            self.updateMap()
        }
    }
}
extension MapViewController {

    private func updateMap() {

        let api = APIManager.sharedInstance

        let left = self.mapView.convertPoint(CGPointMake(0, self.mapView.frame.size.height), toCoordinateFromView: self.mapView)
        let right = self.mapView.convertPoint(CGPointMake(self.mapView.frame.size.width, 0), toCoordinateFromView: self.mapView)

        api.searchPhotosFromLocation(position: (left, right)) { (response) in
            switch response.result {
            case .Success:
                let photos = response.result.value

                var annotations: [PhotoAnnotation]! = []

                for photo in photos! {
                    let annotation = PhotoAnnotation(photo: photo)
                    annotation.preloadImages()
                    annotations.append(annotation)
                }

                self.mapsAnnotations = annotations
                
                self.mapView.setNeedsDisplay()

            case .Failure(let error):
                print("Error: \(error.localizedDescription)")
                self.mapsAnnotations = []
            }
        }
    }

    // MARK: MKMapViewDelegate
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.updateMap()
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            return nil
        }

        var pin: MKPinAnnotationView!

        pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.enabled = true

        pin.leftCalloutAccessoryView = UIButton(frame: CGRectMake(0, 0, 30, 30))

        let button: UIButton = (pin.leftCalloutAccessoryView as? UIButton)!
        button.imageView?.contentMode = .ScaleAspectFit

        pin.annotation = annotation;

        return pin
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation: PhotoAnnotation = (view.annotation as? PhotoAnnotation)!

        self.selectecAnnotation = annotation

        let detailViewController = PhotoDetailViewController(photoAnnotation: annotation)
        self.presentViewController(detailViewController, animated: true, completion: nil)
    }

    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if view.leftCalloutAccessoryView!.isKindOfClass(UIButton) {
            view.leftCalloutAccessoryView = UIButton(frame: CGRectMake(0, 0, 30, 30))

            let button: UIButton = (view.leftCalloutAccessoryView as? UIButton)!
            button.setImage(nil, forState: .Normal)
        }
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.leftCalloutAccessoryView!.isKindOfClass(UIButton) {
            if view.annotation!.isKindOfClass(PhotoAnnotation) {
                let annotation = view.annotation as? PhotoAnnotation

                let image = annotation?.cachedBigImage

                let button = view.leftCalloutAccessoryView as? UIButton
                button?.setImage(image, forState: .Normal)
                button?.imageView?.contentMode = .ScaleAspectFill
            }
        }
    }

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.userLocation = userLocation.coordinate
        self.mapView.setCenterCoordinate(userLocation.coordinate, animated: true)

        if !MapViewController.startedUserLocation {
            MapViewController.startedUserLocation = true
            self.mapView.showsUserLocation = false
            self.mapView.userTrackingMode = .None
            
            self.updateMap()
        }
    }
}

