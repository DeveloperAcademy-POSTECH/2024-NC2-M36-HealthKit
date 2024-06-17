//
//  Helper+CustomFont.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/17/24.
//

import SwiftUI

struct FontModifier: ViewModifier {
    
    enum FontWeight: String {
        case Grandiflora = "GrandifloraOne-Regular"
        case Cafe24 = "Cafe24Syongsyong"
    }
    
    var weight: FontWeight
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(weight.rawValue, size: size))
    }
}

extension View {
    
    /// 프리텐다드 커스텀 폰트를 적용 후 반환
    func customFont(_ weight: FontModifier.FontWeight, _ size: CGFloat) -> some View {
        modifier(FontModifier(weight: weight, size: size))
    }
}
