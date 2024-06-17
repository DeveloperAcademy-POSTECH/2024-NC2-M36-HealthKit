//
//  homeView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/17/24.
//

import SwiftUI

struct homeView: View {
    
    var body: some View {
        ZStack{
            Color.background2.ignoresSafeArea()
            VStack{
                HStack{
                    textComponent(text: "적당히\n즐기시는군요!", size: 28, weight: .bold)
                        .padding(.init(top: 0, leading: 36, bottom: 20, trailing: 0))
                    Spacer()
                }
                caffeineGage()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .ignoresSafeArea()
                    
                    VStack{
                        HStack{
                            textComponent(text: "어디서 드시나요?", size: 24, weight: .semibold)
                                .padding(.init(top: 24, leading: 36, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack{
                                positionButton(image: "appleLogo", text: "Developer\nAcademy")
                                    .padding(.trailing, 24)
                                positionButton(image: "coffeeNearme", text: "coffee\nnearme")
                                    .padding(.trailing, 24)
                                positionButton(image: "convenienceStore", text: "convenience\nstore")
                                    .padding(.trailing, 24)
                            }
                            .padding(.init(top: 12, leading: 24, bottom:28, trailing: 0))
                        })
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func caffeineGage() -> some View {
        ZStack{
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 20)
                .shadow(color: .shadow.opacity(0.3), radius: 24, y: 8)
            
            Circle()
                .trim(from: 0, to: 32 / 100)
                .stroke(Color.gage01, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
            
            VStack{
                Text("32%")
                    .font(.system(size: 60, weight: .bold))
                Text("(128/400mg)")
                    .font(.system(size: 32, weight: .bold))
            }
        }
        .frame(width: 300, height: 300)
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func textComponent(text: String, size: CGFloat, weight: Font.Weight) -> some View {
        Text(text)
            .font(.system(size: size, weight: weight))
            .foregroundColor(.text)
    }
    
    @ViewBuilder
    private func positionButton(image: String, text: String) -> some View {
        Button{
            
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width: 180, height: 220)
                    .shadow(color: .gray, radius: 8, y: 8)
                
                VStack{
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 12)
                    
                    Text(text)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    homeView()
}
