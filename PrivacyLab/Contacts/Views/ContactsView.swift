//
//  ContactsView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

#warning("Contacts Step 5: As of now, the app gives no reason why it needs to access the user's contacts. Let's give a more descriptive reason so the user knows exactly how their personal data will be used. In the Navigator on the top left, click the blue project file labelled 'PrivacyLab' and click the 'Info' tab. Look for the key labelled 'Privacy - Contacts Usage Description' and give it a more useful value. For example 'PrivacyLab requires this permission in order to import your contacts names into your friend list.'")

struct ContactsView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State private var friendName = ""
    @State private var friends = [Contact]()
    
    @State private var addingNewFriend = false
    @State private var addingNewFriendManually = false
    @State private var addingNewFriendFromContacts = false
    @State private var triedToImportContactsWithoutPermission = false
    
    var body: some View {
        NavigationStack {
            List(friends) { contact in
                HStack(spacing: 0) {
                    Text(contact.givenName)
                    Text(" ")
                    Text(contact.familyName)
                }
            }
            .alert("Add new Friend", isPresented: $addingNewFriend) {
                VStack {
                    Button("Import From Contacts") {
                        Task {
#warning("Contacts Step 2: When the user taps 'Import From Contacts', that's the exact moment when we should request permission to the user's contacts. Remove the line of code requesting permission to the user's contacts from ContentView and paste it here instead. Make sure to call it asynchronously using the keyword `await`")
                            if contactsViewModel.hasContactsPermission {
                                addingNewFriendFromContacts = true
                            } else {
#warning("Contacts Step 3: If the user has declined to give the user access to contacts, we need to tell the user why this action is not allowed. When this happens, let's toggle an alert that gives a helpful description to the user. This description should include 1) Why the action failed and 2) How to enable permissions to allow for this action. We aleady have an alert with a proper description, but we need to set `triedToImportContactsWithoutPermission` to `true` in order to display it. Go ahead and do that here in this `else` block.")
                            }
                        }
                    }
                    Button("Add Manually") {
                        addingNewFriendManually = true
                    }
                }
            }
            .alert("Add Manually", isPresented: $addingNewFriendManually) {
                VStack {
                    TextField("Friend Name", text: $friendName)
                    HStack {
                        Button("Cancel", role: .cancel) { }
                        Button("Add") {
                            addFriend()
                        }
                    }
                }
            }
            .alert("PrivacyLab needs permission to read your contacts for you to import them.", isPresented: $triedToImportContactsWithoutPermission) {
                HStack {
                    Button("No thanks") { }
                    Button("Take me there") {
#warning("Contacts Step 4: If the user taps 'Take me there' we should actually open the Settings app to PrivacyLab's permission page. We can do that by calling the `navigateToSettings` method of the `SettingService` class. This method is marked as a `static` method, meaning we call this method on the SettingsService type, rather than an instance of SettingsService. You can do that by typing `SettingsService.navigateToSettings()`.")
                    }
                }
            } message: {
                Text("Enable this permission in your device's Settings to access this feature")
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
    
    func addFriend() {
        friends.append(Contact(givenName: friendName, familyName: ""))
    }
}
