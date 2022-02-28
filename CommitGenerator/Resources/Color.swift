//
//  Color.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import Foundation
import SwiftUI

extension Color {
    static let brand = Color("primary")
    static let error = Color("error")
    static let background1 = Color("background")
    static let background2 = Color("background2")
    static let disable = Color("disable")
    static let line1 = Color("line1")
    static let line2 = Color("line2")
    static let line3 = Color("line3")
    static let text1 = Color("text1")
    static let text2 = Color("text2")
    static let text3 = Color("text3")
    
    init(hex:String) {
        
        let scanner = Scanner(string: hex)
        
        _ = scanner.scanString("#")
        
        var rgb : UInt64 = 0
        
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)

    }
  
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
