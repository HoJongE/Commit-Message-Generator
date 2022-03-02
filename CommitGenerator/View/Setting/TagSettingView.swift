//
//  TagSettingView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct TagSettingView: View {
    
    private let title : String
    private let systemName : String
    private let color : Color
    
    init(_ title : String,image systemName : String,tint color : Color){
        self.title = title
        self.systemName = systemName
        self.color = color
    }
    
    var body: some View {
        
        HStack(alignment:.center) {
            Image(systemName: systemName)
                .imageScale(.large)
                .foregroundColor(color)
            Text(title)
                .foregroundColor(.white)
                .font(.body)
                .padding(.leading,8)
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: 55,alignment: .leading)
        
        
    }
}

struct TagSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TagSettingView("태그", image: "tag.fill", tint: .brand)
            .previewLayout(.sizeThatFits)
            .background(Color.background1)
    }
}
