//
//  ContactsManager.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

@MainActor
class ContactsManager: ObservableObject {
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
}
