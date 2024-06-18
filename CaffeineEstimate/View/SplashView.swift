//
//  SplashView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/17/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var navigationPathModel: NavigationPathModel = .init()
    
    var body: some View {
        NavigationStack(path: $navigationPathModel.paths) {
            ZStack {
                // 배경색 지정
                Color.background1.ignoresSafeArea()
                
                VStack {
                    Image("splashLogo")
                    
                    Text("nearApple")
                        .customFont(.Cafe24, 40)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    navigationPathModel.paths.append(.homeView)
                }
            }
            .navigationPathDestination()
        }
        .environment(navigationPathModel)
    }
}

#Preview {
    SplashView()
}
