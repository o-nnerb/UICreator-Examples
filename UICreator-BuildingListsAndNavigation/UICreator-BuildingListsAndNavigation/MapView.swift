//
//  MapView.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import MapKit

class MapView: UIViewCreator, UICViewRepresentable {
    typealias View = MKMapView

    let coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

    func makeUIView() -> MKMapView {
        MKMapView()
    }

    func updateView(_ view: MKMapView) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

import SwiftUI
class MapView_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(MapView(coordinate: landmarkData[0].locationCoordinate))
    }
}
