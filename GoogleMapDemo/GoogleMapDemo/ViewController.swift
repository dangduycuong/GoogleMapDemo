//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by duycuong on 5/13/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, GMSMapViewDelegate {
    
    // You don't need to modify the default init(nibName :bundle: ) method.
    
    var latitude: Double?
    var longitude: Double?
    var mapView: GMSMapView?
    var listLocation = [CLLocationCoordinate2D]()
    var superLocation = [[CLLocationCoordinate2D]]()
    
//    override func loadView() {
//        // Create a GMSCameraPossition that tells the map to display the
//        // coordinate -33.86, 151.20 at zoom level 6.
//        // latitude: vĩ độ
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
//        //let camera = GMSCameraPosition.camera(withLatitude: 20.0169525, longitude: 106.0283341, zoom: 6)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//
//        // Creates a market in the center of the map.
//        // marker: đánh dấu
//        let marker = GMSMarker()
//        // position: vị trí
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        //marker.position = CLLocationCoordinate2D(latitude: 20.0169525, longitude: 106.0283341)
//
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        drawPolyline()
    }

    func loadMap() {
        var camera = GMSCameraPosition()
        let marker = GMSMarker()
        latitude = 37.36
        longitude = -122.0

        if let latitude = latitude, let longtitude = longitude {
            camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom: 25.0)
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.map = mapView
        }
        
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        if let mapView = mapView {
            
            //            locationManager.delegate = self
            mapView.delegate = self
            mapView.mapType = .normal
            view.addSubview(mapView)

            let projection = mapView.projection.visibleRegion()

            let topLeftCorner: CLLocationCoordinate2D = projection.farLeft
            //            let topRightCorner: CLLocationCoordinate2D = projection.farRight
            //            let bottomLeftCorner: CLLocationCoordinate2D = projection.nearLeft
            let bottomRightCorner: CLLocationCoordinate2D = projection.nearRight

            //                x1 = topLeftCorner.latitude
            //                y1 = topLeftCorner.longitude
            //                x2 = bottomRightCorner.latitude
            //                y2 = bottomRightCorner.longitude
        }




        self.view.layoutIfNeeded()
    }

    func drawPolyline() {
        //Step 1:
        // var mapView = GMSMapView()
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeColor = .red
        rectangle.strokeWidth = 3
        rectangle.map = mapView

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
        marker.position = CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0)
        marker.position = CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2)
        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2)
        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
        
        
        
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.map = mapView
        //Step 2:
        var oldPolylineArr = [GMSPolyline]()

            // Array

        //Step 3:
        oldPolylineArr.append(rectangle)
        

        //Step 4:
//        for p in (0 ..< oldPolylineArr.count) {
//            oldPolylineArr[p].map = nil
//        }

        // is NOT Array

        //Step 3:
        // oldPolyline = polyline

        //Step 4:
        // oldPolyline.map = nil
    }
    
    var listPolyline = [GMSPolyline]()
    var index = 0
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if listLocation.count == 4 {
            listLocation.removeAll()
            index = 0
        } else {
            listLocation.append(coordinate)
            let marker = GMSMarker()
            marker.position = listLocation[index]
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.map = mapView
            
            
            index += 1
            
            superLocation.append(listLocation)
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        
        if let index = overlay.title {
            let index = Int(index)
            listPolyline[index!].strokeColor = .brown
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5, execute: {
                self.listPolyline[index!].map = nil
//                self.listPolyline[1].map = nil
            })
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        for i in 0..<superLocation.count {
            let rectangle = GMSPolyline()
            let path = GMSMutablePath()
            
            for item in superLocation[i] {
                path.add(item)
            }
            
            rectangle.path = path
            rectangle.strokeColor = .green
            rectangle.strokeWidth = 3
            rectangle.isTappable = true
            rectangle.title = "\(i)"
            
            rectangle.map = mapView
            listPolyline.append(rectangle)
        }
        return true
    }

}

