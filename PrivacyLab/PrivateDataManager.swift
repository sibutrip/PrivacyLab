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
    
    // MARK: - Location
    let locationManager = CLLocationManager()
    @Published var hasLocationPermission = false
    @Published var location: CLLocation?
    @Published var mapArea: MKMapRect?
    
    override init() {
        super.init()
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
    
    // MARK: - Contacts
    
    @Published var contacts: [Contact] = []
    let contactService = ContactService()
    func loadContacts() async throws {
        let contacts = try await contactService.loadContacts()
        self.contacts = contacts
    }
    
    func addContact(givenName: String, familyName: String) async throws {
        let addedContact = Contact(givenName: givenName, familyName: familyName)
        try await contactService.add(addedContact)
        contacts.append(addedContact)
    }
    
    // MARK: - Health
    
    // get permission for health data. (use x method)
    // display the data
    // give them instructions on what to do if they havent given permission
}
