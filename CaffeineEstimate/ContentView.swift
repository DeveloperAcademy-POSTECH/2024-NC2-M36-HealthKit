//
//  ContentView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: HealthManager
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button{
//                manager.fetchTodaySteps()
//                manager.fetchWeekSteps()
                manager.fetchAllSteps()
            } label: {
                Text("print")
            }
        }
        .padding()
//        .onAppear {
//            manager.fetchTodaySteps()
//        }
    }
}

#Preview {
    ContentView()
}
