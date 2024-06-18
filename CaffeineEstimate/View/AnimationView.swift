//
//  AnimationView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/18/24.
//

import SwiftUI

struct AnimationView: View {
    
    @Environment(NavigationPathModel.self) private var navigationPathModel
    
    @State var isMove: Bool = false
    @State var isAngle: Bool = false
    @State var isSteam: Bool = false
    @State var isSteamMove1: Bool = false
    @State var isSteamMove2: Bool = false
    
    var body: some View {
        ZStack{
            Color.background1.ignoresSafeArea()
            VStack{
                ZStack{
                    VStack{
                        Spacer()
                        Image("steam")
                            .resizable()
                            .frame(width: isSteam ? 100 : 10, height: isSteam ? 100 : 10)
                            .opacity(isSteam ? 1 : 0)
                    }
                    .frame(height: 100)
                    
                    Rectangle()
                        .fill(.background1.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .offset(y: isSteamMove1 ? -100 : 0)
                        .animation(.easeIn(duration: 1.2), value: isSteamMove1)
                    
                    Rectangle()
                        .fill(.background1.opacity(0.8))
                        .frame(width: 100, height: 100)
                        .offset(y: isSteamMove2 ? -100 : 0)
                        .animation(.easeIn(duration: 1.0), value: isSteamMove2)
                }
                
                VStack{
                    Image("splashLogo")
                        .rotationEffect(Angle(degrees: isAngle ? 0 : -20))
                        .animation(.easeInOut(duration: 0.5), value: isAngle)
                }
                .offset(x: isMove ? 0 : -280)
                .animation(.easeInOut(duration: 0.8), value: isMove)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isMove.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                isAngle.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeOut(duration: 0.7)) {
                    isSteam.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                isSteamMove1.toggle()
                isSteamMove2.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                navigationPathModel.paths.removeLast(2)
            }
        }
    }
}

#Preview {
    AnimationView()
}
