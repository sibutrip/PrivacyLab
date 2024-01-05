//
//  MapViewModel.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 1/3/24.
//

import Foundation
import CoreLocation
import MapKit

@MainActor
class MapViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var mapArea: MKMapRect?
    public var hasLocationPermission: Bool {
        mapArea != nil
    }
    
    public func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined, .restricted, .denied:
            return
        @unknown default:
            return
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task {
            await MainActor.run {
                self.mapArea = MKMapRect(origin: MKMapPoint(locations[0].coordinate), size: MKMapSize(width: 2500, height: 2500))
            }
        }
        manager.stopUpdatingLocation()
    }
}
