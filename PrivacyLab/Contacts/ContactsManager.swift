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
}
