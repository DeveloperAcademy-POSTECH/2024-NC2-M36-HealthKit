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
    
    @State private var expandedItems: [UUID: Bool] = [:]
    
    var body: some View {
        
        let titles = ["NESPRESSO"]
        let data = [Capsules]
        
        ZStack{
            VStack{
                List {
                    ForEach(titles.indices, id: \.self) { index in
                        Section(header: Text(titles[index])) {
                            ForEach(data[index], id: \.id) { data in
                                DisclosureGroup(
                                    isExpanded: Binding(
                                        get: { expandedItems[data.id] ?? false },
                                        set: { expandedItems[data.id] = $0 }
                                    ),
                                    content: {
                                        dataDetail(image: data.image, detail: data.details, amount: data.caffeine)
                                    },
                                    label: {
                                        HStack {
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(data.color)
                                            Text(data.name)
                                        }
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
    private func dataDetail(image: String, detail: String, amount: Double) -> some View {
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
                    manager.saveCaffeine(caffeineAmount: amount)
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
