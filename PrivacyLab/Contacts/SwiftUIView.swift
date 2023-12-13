//
//  AddingFriendsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/13/23.
//

import SwiftUI

struct AddingFriendsView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    @Environment(\.dismiss) var dismiss
    @Binding var friends: [Contact]
    var body: some View {
        NavigationStack {
            List {
                ForEach(privateDataManager.contacts) { contact in
                    ContactDetailView(contact: contact, addedFriendsFromContacts: $friends)
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .onDisappear {
                friends.forEach { contact in
                    privateDataManager.contacts = privateDataManager.contacts.filter { $0.id != contact.id }
                }
            }
        }
    }
}

#Preview {
    AddingFriendsView(friends: .constant([]))
}
