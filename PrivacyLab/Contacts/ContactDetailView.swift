//
//  ContactDetailView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/13/23.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contact
    @State private var isSelected: Bool
    @Binding var addedFriendsFromContacts: [Contact]
    var body: some View {
        HStack(spacing: 0) {
            Toggle("", isOn: $isSelected)
                .labelsHidden()
                .padding(.trailing)
            Text(contact.givenName)
            Text(" ")
            Text(contact.familyName)
        }
        .onChange(of: isSelected) { _, newValue in
            if addedFriendsFromContacts.contains(where: { $0.id == contact.id }) {
                addedFriendsFromContacts = addedFriendsFromContacts.filter { $0.id != contact.id }
            } else {
                addedFriendsFromContacts.append(contact)
            }
        }
    }
    init(contact: Contact, addedFriendsFromContacts: Binding<[Contact]>) {
        self.contact = contact
        _addedFriendsFromContacts = addedFriendsFromContacts
        if addedFriendsFromContacts.contains(where: { $0.id == contact.id }) {
            _isSelected = .init(initialValue: true)
        } else {
            _isSelected = .init(initialValue: false)
        }
    }
}

#Preview {
    List {
        ContactDetailView(contact: .init(givenName: "Cory", familyName: "Tripathy"), addedFriendsFromContacts: .constant([]))
        ContactDetailView(contact: .init(givenName: "Kevin", familyName: "Buchhholzz"), addedFriendsFromContacts: .constant([]))
    }
}
