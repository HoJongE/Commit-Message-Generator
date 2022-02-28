//
//  TabView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        
        TabView {
            NavigationView {
                CommitWriteHost()
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("커밋 작성")
            }
            
            Text("하이")
                .tabItem {
                    Image(systemName: "gearshape.2")
                    Text("설정")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
