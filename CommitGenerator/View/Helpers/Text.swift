//
//  Text.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import SwiftUI

struct PointText: View {
    let text : String
    
    init(_ text : String){
        self.text = text
    }
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
            Text(text)
                .font(.subheadline)
                
        }
    }
}

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        PointText("안녕하세요")
            .previewLayout(.sizeThatFits)
    }
}
