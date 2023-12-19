//
//  AddingFriendsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/13/23.
//

import SwiftUI

struct AddingFriendsView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    @State var hasNoPermission = false
    @Environment(\.dismiss) var dismiss
    @Binding var friends: [Contact]
    var body: some View {
        NavigationStack {
            List {
                ForEach(privateDataManager.contacts) { contact in
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
                    if !privateDataManager.hasContactsPermission {
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
