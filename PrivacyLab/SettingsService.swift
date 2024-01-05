//
//  SettingsService.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 1/3/24.
//

import Foundation
import UIKit

class SettingsService {
    
    /// Call this from a `View` to navigate the user to the app's settings page.
    ///
    ///  i.e. `SettingsService.navigateToSettings()`
    public static func navigateToSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }

    public static func navigateToHealthSettings() {
        UIApplication.shared.open(URL(string: "x-apple-health://")!, options: [:], completionHandler: nil)
    }
}
