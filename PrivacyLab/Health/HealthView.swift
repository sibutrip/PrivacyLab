//
//  HealthView.swift
//  PrivacyLab
//
//  Created by Cory Tripathy on 12/7/23.
//

import SwiftUI

struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    var body: some View {
        Button("Do thing") {
//            print(healthViewModel.stepsFromToday() ?? 0)
        }
    }
}

#Preview {
    HealthView()
}
