//
//  ContactsViewModel.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 1/3/24.
//

import Foundation
import UIKit

@MainActor
class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var hasContactsPermission = false
    
    private let contactService = ContactService()
    
    func getContactsPermission() async throws {
        self.hasContactsPermission = try await contactService.requestPermission()
        self.contacts = try await contactService.loadContacts()
    }
    
    func addContact(givenName: String, familyName: String) async throws {
        let addedContact = Contact(givenName: givenName, familyName: familyName)
        try await contactService.add(addedContact)
        contacts.append(addedContact)
    }
    
    init() {
        Task {
            try await getContactsPermission()
        }
    }
}
