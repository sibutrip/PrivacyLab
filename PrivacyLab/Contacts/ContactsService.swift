//
//  ContactsService.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import Contacts

actor ContactService {
    private let contactStore = CNContactStore()
    func requestPermission() async throws -> Bool {
        return try await contactStore.requestAccess(for: .contacts)
    }
    func loadContacts() async throws -> [Contact] {
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        var contacts = [CNContact]()
        try self.contactStore.enumerateContacts(with: fetchRequest) { contact, stop in
            contacts.append(contact)
        }
        return contacts.map { Contact(givenName: $0.givenName, familyName: $0.familyName) }
    }
    
    func add(_ contact: Contact) async throws { }
    
}
