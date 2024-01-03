//
//  AddingFriendsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/13/23.
//

import SwiftUI

struct AddingFriendsView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State var hasNoPermission = false
    @Environment(\.dismiss) var dismiss
    @Binding var friends: [Contact]
    var body: some View {
        NavigationStack {
            List {
                ForEach(contactsViewModel.contacts) { contact in
                    ContactDetailView(contact: contact, friends: $friends)
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddingFriendsView(friends: .constant([]))
}
