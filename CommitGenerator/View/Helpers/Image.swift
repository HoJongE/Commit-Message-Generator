//
//  Image.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import SwiftUI
import SDWebImageSwiftUI

struct GithubImage: View {
    var body: some View {
        Image("github")
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
            .shadow(color: .white, radius: 3)
            .background(Circle().foregroundColor(.white).padding(1))
        
    }
}

struct CircleWebImage : View {
    let url : String
    let width : CGFloat
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .clipShape(Circle())
            .frame(width: width, height: width)
            .shadow(color: .white, radius: 1)
            .overlay(Circle().stroke(.gray, lineWidth: width/40))
    }
}


struct Image_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GithubImage()
            CircleWebImage(url: "https://avatars.githubusercontent.com/u/57793298?v=4", width: 50)
        }
        .padding()
        .background(Color.background1)
        .previewLayout(.sizeThatFits)
    }
}
