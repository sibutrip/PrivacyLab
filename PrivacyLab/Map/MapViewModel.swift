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
class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var hasLocationPermission = false
    @Published var location: CLLocation?
    @Published var mapArea: MKMapRect?
    
    func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            return
        case .restricted:
            return
        case .denied:
            return
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
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
