//
//  CaffeineEstimateApp.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/12/24.
//

import SwiftUI

@main
struct CaffeineEstimateApp: App {
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            AcademyView()
                .environmentObject(manager)
        }
    }
}
