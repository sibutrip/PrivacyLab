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
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State private var friendName = ""
    @State private var addingNewFriend = false
    @State private var addingNewFriendManually = false
    @State private var addingNewFriendFromContacts = false
    @State private var friends = [Contact]()
    
    @State var errorText: String?
    var body: some View {
        NavigationStack {
            Group {
                List(friends) { contact in
                    HStack(spacing: 0) {
                        Text(contact.givenName)
                        Text(" ")
                        Text(contact.familyName)
                    }
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
                            // TODO add action here
                        }
                    }
                }
            }
            .task {
                do {
                    try await contactsViewModel.getContactsPermission()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .sheet(isPresented: $addingNewFriendFromContacts) {
                AddingFriendsView(friends: $friends)
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
