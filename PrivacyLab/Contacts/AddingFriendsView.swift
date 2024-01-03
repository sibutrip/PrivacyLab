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
            .onAppear {
                Task {
                    if !contactsViewModel.hasContactsPermission {
                        hasNoPermission = true
                    }
                }
            }
        }
        .alert("No Contacts Authorization Given", isPresented: $hasNoPermission) {
            Button("OK") { dismiss() }
        } message: {
            Text("Go to settings to enable this permission")
        }
    }
}

#Preview {
    AddingFriendsView(friends: .constant([]))
}
