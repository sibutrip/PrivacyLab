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
    
    public func requestContactsPermission() async {
        do {
            self.hasContactsPermission = try await contactService.requestPermission()
            self.contacts = try await contactService.loadContacts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
