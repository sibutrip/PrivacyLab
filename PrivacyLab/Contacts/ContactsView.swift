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
///
/// toolbar button should show an error saying why they cant create a contact if they havent given permission

struct ContactsView: View {
    @EnvironmentObject var privateDataManager: PrivateDataManager
    @State private var hasContactsPermission = true
    @State private var friendName = ""
    @State private var addingNewFriend = false
    @State private var addingNewFriendManually = false
    @State private var addingNewFriendFromContacts = false
    @State private var addedFriendsFromContacts = [Contact]()
    
    @State var errorText: String?
    var showingError: Binding<Bool> {
        Binding {
            errorText != nil
        } set: { newValue in
            if !newValue { errorText = nil }
        }
    }
    var body: some View {
        NavigationStack {
            Group {
                if hasContactsPermission {
                    List(addedFriendsFromContacts) { contact in
                        HStack(spacing: 0) {
                            Text(contact.givenName)
                            Text(" ")
                            Text(contact.familyName)
                        }
                    }
                    // if they dont have permission
                    // make an alert to take them to settings (provide that function for them)
                    // they should make the text that tells the user what to do to enable permission
                    
                } else {
                    Text("hasContactsPermission is false")
                }
            }
            .alert("Add new Friend", isPresented: $addingNewFriend) {
                VStack {
                    Button("Import From Contacts") {
                        Task {
                            addingNewFriendFromContacts = true
                        }
                    }
                    Button("Add Manually") {
                        addingNewFriendManually = true
                    }
                }
            }
            .alert("Add Manually", isPresented: $addingNewFriendManually) {
                VStack {
                    TextField("Friend name", text: $friendName)
                    HStack {
                        Button("Cancel", role: .cancel) { }
                        Button("Add") {
                            // Todo add action here
                        }
                    }
                }
            }
            .sheet(isPresented: $addingNewFriendFromContacts) {
                AddingFriendsView(friends: $addedFriendsFromContacts)
            }
            .alert(errorText ?? "", isPresented: showingError) {
                Button("OK") {
                    showingError.wrappedValue = false
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                Button {
                    addingNewFriend = true
                } label: {
                    Label("Add New Friend", systemImage: "plus")
                }
            }
        }
    }
    func addFriend() { }
}
