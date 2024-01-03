//
//  Contact.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import Foundation

struct Contact: Identifiable {
    let id = UUID()
    let givenName: String
    let familyName: String
}
