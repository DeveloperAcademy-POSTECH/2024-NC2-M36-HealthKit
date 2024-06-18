//
//  HomeView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/17/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(NavigationPathModel.self) private var navigationPathModel
    @EnvironmentObject var manager: HealthManager
    
    @State private var todayCaffeine: Int = 0
    
    let comment = ["적당히\n즐기시는군요!", "오늘 하루도\n화이팅!", "일일 권장 섭취량을\n넘었습니다!!"]
    
    var body: some View {
        ZStack{
            Color.background2.ignoresSafeArea()
            
            VStack{
                
                HStack{
                    if todayCaffeine < 400 {
                        textComponent(text: todayCaffeine < 200 ? comment[0] : comment[1], size: 28, weight: .bold)
                    } else {
                        textComponent(text: comment[2], size: 28, weight: .bold, color: .gage03)
                    }
                    
                    Spacer()
                }
                .padding(.init(top: 12, leading: 36, bottom: 20, trailing: 0))
                
                caffeineGage(caffeineMg: todayCaffeine, caffeinePercentage: todayCaffeine / 4)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .ignoresSafeArea()
                    
                    VStack{
                        
                        HStack{
                            textComponent(text: "어디서 드시나요?", size: 24, weight: .semibold)
                                .padding(.init(top: 16, leading: 36, bottom: 0, trailing: 0))
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
        .onAppear {
            manager.fetchTodayCaffeine{ caffeine in
                if let caffeine = caffeine {
                    todayCaffeine = caffeine
                }
            }
        }
    }
    
    @ViewBuilder
    private func caffeineGage(caffeineMg: Int, caffeinePercentage: Int) -> some View {
        
        ZStack{
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 20)
                .shadow(color: .shadow, radius: 20, y: 8)
            
            if caffeineMg < 400{
                Circle()
                    .trim(from: 0, to: CGFloat(caffeinePercentage) / 100)
                    .stroke(caffeineMg < 200 ? .gage01 : .gage02, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
            } else {
                Circle()
                    .trim(from: 0, to: 100)
                    .stroke(.gage03, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
            }
            
            VStack{
                Text("\(caffeinePercentage)%")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(caffeineMg < 400 ? .black : .gage03)
                
                Text("(\(caffeineMg)/400mg)")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(caffeineMg < 400 ? .black : .gage03)
            }
        }
        .frame(width: 300, height: 300)
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func textComponent(text: String, size: CGFloat, weight: Font.Weight, color: Color = .text) -> some View {
        
        Text(text)
            .font(.system(size: size, weight: weight))
            .foregroundColor(color)
    }
    
    @ViewBuilder
    private func positionButton(image: String, text: String) -> some View {
        
        Button{
            navigationPathModel.paths.append(.academyView)
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width: 180, height: 220)
                    .shadow(color: .gray.opacity(0.3), radius: 8, y: 8)
                
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
