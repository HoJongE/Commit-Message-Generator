//
//  TagRow.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct TagRow: View {
    let tag : Tag
    let selected : Bool
    
    var body: some View {
        VStack(alignment:.leading,spacing: 8) {
            HStack {
                Text("이름")
                    .foregroundColor(.text3)
                    .font(.footnote)
                Spacer()
                
                if selected {
                    Label("현재 선택됨!", systemImage: "checkmark.circle")
                        .foregroundColor(.green)
                }
            }
            Text(tag.name ?? "이름 없음").font(.body)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            if let description = tag.tagDescription {
                
                Divider()
                    .background(Color.white)
                Text("설명")
                    .foregroundColor(.text3)
                    .font(.footnote)
                Text(description)
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .lineSpacing(4)
            }
            
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth:.infinity,alignment: .topLeading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(Color(hex: tag.colorHex ?? "123456") ).opacity(0.4))
        
    }
}

struct TagRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let mockedCoreData = MockedCoreData.shared
        
        Group {
            TagRow(tag: mockedCoreData.tag(),selected: true)
            TagRow(tag: mockedCoreData.tag(),selected: false)
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        
    }
}
