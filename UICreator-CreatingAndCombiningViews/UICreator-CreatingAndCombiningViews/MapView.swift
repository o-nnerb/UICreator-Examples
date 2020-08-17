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

class MapView: UICViewRepresentable {
    typealias View = MKMapView

    func makeUIView() -> MKMapView {
        MKMapView()
    }

    func updateView(_ view: MKMapView) {
        let coordinate = CLLocationCoordinate2D(
            latitude: -22.9518961, longitude: -43.2105182)
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS

import SwiftUI
class MapView_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(MapView())
    }
}

#endif
