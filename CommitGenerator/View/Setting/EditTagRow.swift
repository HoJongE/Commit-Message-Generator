//
//  EditTagRow.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI


//MARK: - EditTagRow

struct EditTagRow: View {
    @ObservedObject var tag : Tag
    
    var body: some View {
        NavigationLink(destination: EditTagView(tag: tag, category: tag.category ?? "")){
            VStack(alignment:.leading,spacing:4) {
                HStack {
                    Text(tag.name ?? "")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Circle().fill(Color(hex: tag.colorHex ?? "#123456")).frame(width: 20, height: 20, alignment: .center).padding(.horizontal,8)
                }
                Text(tag.tagDescription ?? "")
                    .foregroundColor(.text3)
                    .font(.system(size: 14))
                    .lineSpacing(4)
            }
        }
        .padding()
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}

//MARK: - EditTagRow Preview

struct EditTagRow_Previews: PreviewProvider {
    static var previews: some View {
        EditTagRow(tag: MockedCoreData.shared.tag())
            .previewLayout(.sizeThatFits)
            .background(Color.background1)
    }
}
