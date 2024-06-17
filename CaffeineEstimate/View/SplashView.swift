//
//  SplashView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/17/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            // 배경색 지정
            Color.background.ignoresSafeArea()
            
            VStack {
                Image("splashLogo")
                
                Text("nearApple")
                    .customFont(.Cafe24, 40)
            }
        }
    }
}

#Preview {
    SplashView()
}
