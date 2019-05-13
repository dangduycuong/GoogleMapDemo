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

class ViewController: UIViewController {
    
    // You don't need to modify the default init(nibName :bundle: ) method.
    
    override func loadView() {
        // Create a GMSCameraPossition that tells the map to display the
        // coordinate -33.86, 151.20 at zoom level 6.
        // latitude: vĩ độ
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
        //let camera = GMSCameraPosition.camera(withLatitude: 20.0169525, longitude: 106.0283341, zoom: 6)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a market in the center of the map.
        // marker: đánh dấu
        let marker = GMSMarker()
        // position: vị trí
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //marker.position = CLLocationCoordinate2D(latitude: 20.0169525, longitude: 106.0283341)
        
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

