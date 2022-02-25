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
            Text(tag.name).font(.body)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Divider()
                .background(Color.white)
            Text("설명")
                .foregroundColor(.text3)
                .font(.footnote)
            Text(tag.tagDescription)
                .foregroundColor(.white)
                .font(.system(size: 14))
            
        }
        .frame(maxWidth:.infinity,alignment: .topLeading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(Color(hex: tag.colorHex)))
        
    }
}

struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagRow(tag: Tag("Feat", "기능을 추가하거나 받아옴,브레이킹 배드 뉴스 엄청난 API 의 수정!", color: "#123456")
                   ,selected: true)
            
            TagRow(tag: Tag("Feat", "기능을 추가하거나 받아옴,브레이킹 배드 뉴스 엄청난 API 의 수정!", color: "#123456")
                   ,selected: false)
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        
    }
}
