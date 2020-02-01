//
//  Landmark.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct Landmark {
    let name: String
    fileprivate let imageName: String
    fileprivate let coordinates: Coordinates
    let country: String
    let city: String

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
}

extension Landmark {
    var image: UIImage {
        .init(imageLiteralResourceName: self.imageName)
    }
}

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

let landmarkData: [Landmark] = [
    Landmark(
        name: "Cristo Redentor",
        imageName: "cristoredentor",
        coordinates: Coordinates(latitude: -22.9518961, longitude: -43.2105182),
        country: "Brazil",
        city: "Rio de Janeiro"
    ),
    Landmark(
        name: "Pão de Açucar",
        imageName: "paodeacucar",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Rio de Janeiro"
    ),
    Landmark(
        name: "Baía dos Porcos",
        imageName: "baiadosporcos",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Fernando de Noronha"
    ),
    Landmark(
        name: "Lençóis Maranhenses",
        imageName: "lencoismaranhenses",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Parque Nacional dos Lençóis Maranhenses"
    ),
    Landmark(
        name: "Iguaçu",
        imageName: "iguacu",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Parque Nacional do Iguaçu"
    ),
    Landmark(
        name: "Teatro Amazonas",
        imageName: "teatroamazonas",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Manaus"
    ),
    Landmark(
        name: "Elevador Lacerda",
        imageName: "elevadorlacerda",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Bahia"
    ),
    Landmark(
        name: "Praia de Ponta Negra",
        imageName: "praiadepontanegra",
        coordinates: Coordinates(latitude: .zero, longitude: .zero),
        country: "Brazil",
        city: "Natal"
    )
]
