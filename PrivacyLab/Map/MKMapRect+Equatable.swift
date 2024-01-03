//
//  MKMapRect+Equatable.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 1/3/24.
//

import MapKit

extension MKMapRect: Equatable {
    public static func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
        lhs.origin.coordinate.latitude == rhs.origin.coordinate.latitude && lhs.origin.coordinate.longitude == rhs.origin.coordinate.longitude
    }
}
