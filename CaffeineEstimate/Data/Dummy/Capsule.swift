//
//  Capsule.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/19/24.
//

import SwiftUI

struct Capsule {
    let id = UUID()
    
    let name: String
    let color: Color
    let image: String
    let details: String
    let caffeine: Double
}

let Capsules: [Capsule] = [
    Capsule(
        name: "피네조",
        color: .finezzo,
        image: "finezzo",
        details: "섬세한 꽃향과 산뜻한 산미\n\n강도5, 에티오피아, 콜롬비아, 기타\n카페인 함량: 50mg",
        caffeine: 50.0
    ),
    Capsule(
        name: "레제로",
        color: .leggero,
        image: "leggero",
        details: "벨벳 질감의 부드러운 곡물향과 코코아향\n\n강도6, 브라질, 콜롬비아, 기타\n카페인 함량: 60mg",
        caffeine: 60.0
    ),
    Capsule(
        name: "포르테",
        color: .forte,
        image: "forte",
        details: "미디엄 로스팅된 맥아향과 과일향\n\n강도7, 브라질, 코스타리카, 기타\n카페인 함량: 70mg",
        caffeine: 70.0
    ),
    Capsule(
        name: "디카페나토",
        color: .decaffeinato,
        image: "decaffeinato",
        details: "풍부한 바디감의 디카페인 커피\n\n강도7, 콜롬비아, 브라질, 기타\n카페인 함량: 2mg",
        caffeine: 2.0
   ),
    Capsule(
        name: "리스트레토",
        color: .ristretto,
        image: "ristretto",
        details: "풍부한 바디감과 강한 로스팅향\n\n강도9, 중앙아메리카, 남아메리카\n카페인 함량: 90mg",
        caffeine: 90.0
   ),
    Capsule(
        name: "리스트레토 인텐소",
        color: .ristrettoIntenso,
        image: "ristrettoIntenso",
        details: "풍부한 바디감과 크리미한 질감\n\n강도12, 남아메리카\n카페인 함량: 120mg",
        caffeine: 120.0
   )
]
