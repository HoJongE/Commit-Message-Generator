//
//  Button.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/25.
//

import SwiftUI

struct SettingButton<Destination : View> : View {
    
    let destination : () -> Destination
    
    init(@ViewBuilder destination: @escaping () -> Destination) {
        self.destination = destination
    }
    var body: some View {
        NavigationLink(destination: destination()){
            Label("설정", systemImage: "gear")
                .foregroundColor(.brand)
                .labelStyle(.titleAndIcon)
        }
    }
}

struct CopyButton : View {
    
    var body: some View {
        Button(action: {}){
            Text("클립보드 복사")
                .font(.body)
                .foregroundColor(.white)
        }
        .frame(maxWidth:.infinity)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 6).fill(Color.brand))
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingButton {
                Text("설정")
            }
            
            CopyButton()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
