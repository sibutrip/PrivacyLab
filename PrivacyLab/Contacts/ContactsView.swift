//
//  ContactsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

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
    @StateObject var contactsManager = ContactsManager()
    var body: some View {
        List(contactsManager.contacts) { contact in
            HStack(spacing: 0) {
                Text(contact.givenName)
                Text(contact.familyName)
            }
        }
        .task {
            do {
                try await contactsManager.loadContacts()
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
