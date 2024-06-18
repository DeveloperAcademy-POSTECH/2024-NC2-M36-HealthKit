//
//  AcademyView.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/18/24.
//

import SwiftUI

struct AcademyView: View {
    
    @Environment(NavigationPathModel.self) private var navigationPathModel
    @EnvironmentObject var manager: HealthManager
    
    @State private var expandedItems: [String: Bool] = [:]
    
    let capsules = ["피네조", "레제로", "포르테", "디카페나토", "리스트레토", "리스트레토 인텐소"]
    let capsuleColors = [Color.finezzo, Color.leggero, Color.forte, Color.decaffeinato, Color.ristretto, Color.ristrettoIntenso]
    let capsuleImages = ["finezzo", "leggero", "forte", "decaffeinato", "ristretto", "ristrettoIntenso"]
    let capsuleDetails = [
        "섬세한 꽃향과 산뜻한 산미\n\n강도5, 에티오피아, 콜롬비아, 기타\n카페인 함량: 50mg",
        "벨벳 질감의 부드러운 곡물향과 코코아향\n\n강도6, 브라질, 콜롬비아, 기타\n카페인 함량: 60mg",
        "미디엄 로스팅된 맥아향과 과일향\n\n강도7, 브라질, 코스타리카, 기타\n카페인 함량: 70mg",
        "풍부한 바디감의 디카페인 커피\n\n강도7, 콜롬비아,브라질,기타\n카페인 함량: 2mg",
        "풍부한 바디감과 강한 로스팅향\n\n강도9, 중앙아메리카, 남아메리카\n카페인 함량: 90mg",
        "풍부한 바디감과 크리미한 질감\n\n강도12, 남아메리카\n카페인 함량: 120mg"
    ]
    let capsuleCaffeines = [50.0, 60.0, 70.0, 2.0, 90.0, 120.0]
    
    var body: some View {
        
        let titles = ["NESPRESSO"]
        let data = [capsules]
        
        ZStack{
            VStack{
                List {
                    ForEach(data.indices, id: \.self) { index in
                        Section(header: Text(titles[index])) {
                            ForEach(data[index].indices, id: \.self) { itemIndex in
                                let item = data[index][itemIndex]
                                DisclosureGroup(
                                    isExpanded: Binding(
                                        get: { expandedItems[item] ?? false },
                                        set: { expandedItems[item] = $0 }
                                    ),
                                    content: {
                                        capsuleDetail(image: capsuleImages[itemIndex], detail: capsuleDetails[itemIndex], amount: capsuleCaffeines[itemIndex])
                                    },
                                    label: {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(capsuleColors[itemIndex])
                                        Text(item)
                                    }
                                )
                            }
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                .background(.background2)
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    @ViewBuilder
    private func capsuleDetail(image: String, detail: String, amount: Double) -> some View {
        HStack{
            VStack{
                Image(image)
                    .padding(.top, 16)
                Spacer()
            }
            VStack{
                Text(detail)
                    .font(.system(size: 16))
                    .padding(.init(top: 8, leading: 8, bottom: 0, trailing: 0))
                
                Button{
                    print("입력")
                    // 데이터 반영
                    manager.saveCaffeine(caffeineAmount: amount)
                    // 애니메이션 화면 구현
                    navigationPathModel.paths.append(.animationView)
                } label: {
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.brand)
                                .frame(width: 72, height: 44)
                            Text("마시기")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(8)
                    }
                }
            }
        }
    }
}

#Preview {
    AcademyView()
}
