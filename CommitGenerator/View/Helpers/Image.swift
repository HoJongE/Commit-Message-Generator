//
//  Image.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import SwiftUI

struct GithubImage: View {
    var body: some View {
        Image("github")
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
            .background(Circle().foregroundColor(.white).padding(1))

    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        GithubImage()
            .previewLayout(.sizeThatFits)
    }
}
