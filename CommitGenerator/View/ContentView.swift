//
//  ContentView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Text("제목")
                .font(.title2)
                .padding()
            
        }
        .navigationTitle("커밋 작성")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                SettingButton {
                    Text("설정")
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity,alignment: .topLeading)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
