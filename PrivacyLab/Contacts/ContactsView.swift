//
//  ContactsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI


/// 1. if you dont give permissions, the app should still be usable
/// make a popup that says "to view contacts enable permissions in settings" with the options "no thanks" and "take me there"
///
/// 2. make a toolbar button to add a contact using the ContactsManager method `addContact`

struct ContactsView: View {
    @State var errorText: String?
    var showingError: Binding<Bool> {
        Binding {
            errorText != nil
        } set: { newValue in
            if !newValue {
                errorText = nil
            }
        }
    }
//    @StateObject var contactsManager = ContactsManager()
    @EnvironmentObject var privateDataManager: PrivateDataManager
    var body: some View {
        List(privateDataManager.contacts) { contact in
            HStack(spacing: 0) {
                Text(contact.givenName)
                Text(" ")
                Text(contact.familyName)
            }
        }
        .task {
            do {
                try await privateDataManager.loadContacts()
            } catch {
                errorText = error.localizedDescription
            }
        }
        .alert(errorText ?? "", isPresented: showingError) {
            Button("OK") {
                showingError.wrappedValue = false
            }
        }
    }
}

//#Preview {
//    ContactsView()
//}
