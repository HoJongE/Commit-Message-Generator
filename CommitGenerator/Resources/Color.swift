//
//  Color.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import Foundation
import SwiftUI

extension Color {
    static let brand : Color = Color("primary")
    static let error : Color = Color("error")
    static let background1 : Color = Color("background")
    static let background2 : Color = Color("background2")
    static let disable : Color = Color("disable")
    static let line1 : Color = Color("line1")
    static let line2 : Color = Color("line2")
    static let line3 : Color = Color("line3")
    static let text1 : Color = Color("text1")
    static let text2 : Color = Color("text2")
    static let text3 : Color = Color("text3")
    
    init(hex:String) {
        
        let scanner : Scanner = Scanner(string: hex)
        
        _ = scanner.scanString("#")
        
        var rgb : UInt64 = 0
        
        scanner.scanHexInt64(&rgb)
        
        let r : Double = Double((rgb >> 16) & 0xFF) / 255.0
        let g : Double = Double((rgb >>  8) & 0xFF) / 255.0
        let b : Double = Double((rgb >>  0) & 0xFF) / 255.0
        
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
    
    var uiColor: UIColor { .init(self) }
        typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
        var rgba: RGBA? {
            var (r, g, b, a): RGBA = (0, 0, 0, 0)
            return uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) ? (r, g, b, a) : nil
        }
        var hexaRGB: String? {
            guard let (red, green, blue, _) = rgba else { return nil }
            return String(format: "#%02x%02x%02x",
                Int(red * 255),
                Int(green * 255),
                Int(blue * 255))
        }
        var hexaRGBA: String? {
            guard let (red, green, blue, alpha) = rgba else { return nil }
            return String(format: "#%02x%02x%02x%02x",
                Int(red * 255),
                Int(green * 255),
                Int(blue * 255),
                Int(alpha * 255))
        }
}
