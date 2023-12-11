//
//  PrivateDataManager.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI
import Contacts
import CoreLocation
import MapKit

@MainActor
class PrivateDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    public func navigateToSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    // MARK: - Contacts
    
    @Published var contacts: [Contact] = []
    private let contactService = ContactService()
    
    func loadContacts() async throws {
        let contacts = try await contactService.loadContacts()
        self.contacts = contacts
    }
    
    func addContact(givenName: String, familyName: String) async throws {
        let addedContact = Contact(givenName: givenName, familyName: familyName)
        try await contactService.add(addedContact)
        contacts.append(addedContact)
    }
    
    
    // MARK: - Location
    private let locationManager = CLLocationManager()
    @Published var hasLocationPermission = false
    @Published var location: CLLocation?
    @Published var mapArea: MKMapRect?
    
    override init() {
        super.init()
    }
    
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
    
    // MARK: - Health
    
    // get permission for health data. (use x method)
    // display the data
    // give them instructions on what to do if they havent given permission
}


extension MKMapRect: Equatable {
    public static func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
        lhs.origin.coordinate.latitude == rhs.origin.coordinate.latitude && lhs.origin.coordinate.longitude == rhs.origin.coordinate.longitude
    }
}
