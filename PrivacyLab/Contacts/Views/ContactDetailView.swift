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
    @Binding var friends: [Contact]
    
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
            if friends.contains(where: { $0.id == contact.id }) {
                friends = friends.filter { $0.id != contact.id }
            } else {
                friends.append(contact)
            }
        }
    }
    init(contact: Contact, friends: Binding<[Contact]>) {
        self.contact = contact
        _friends = friends
        if friends.contains(where: { $0.id == contact.id }) {
            _isSelected = .init(initialValue: true)
        } else {
            _isSelected = .init(initialValue: false)
        }
    }
}

#Preview {
    List {
        ContactDetailView(contact: .init(givenName: "Cory", familyName: "Tripathy"), friends: .constant([]))
        ContactDetailView(contact: .init(givenName: "Kevin", familyName: "Buchholz"), friends: .constant([]))
    }
}
