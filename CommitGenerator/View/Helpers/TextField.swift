//
//  TextField.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct RoundedTextField<Content: View>: View {
    
    let editorType : EditorType
    var text : Binding<String>
    
    let content : () -> Content
    
    init(_ editorType:EditorType,_ text : Binding<String>,@ViewBuilder content : @escaping () -> Content) {
        self.editorType = editorType
        self.text = text
        self.content = content
    }
    
    var body: some View {
        NavigationLink(destination: FullScreenTextEditor(editorType: editorType, text: text,content: content)) {
            VStack(alignment:.leading){
                Text(editorType.title)
                    .foregroundColor(.text3)
                    .font(.caption)
                Text(text.wrappedValue)
                    .foregroundColor(.black)
                    .frame(minHeight:30,maxHeight: 100,alignment: .topLeading)
                    .font(.body)
                
                HStack {
                    Spacer()
                    Text("\(text.wrappedValue.count)/\(editorType.textLimit)")
                        .font(.caption)
                        .foregroundColor(.text2)
                }
            }
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth:.infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(.white))
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField(.Body, .constant("아하하하!!"), content: {
            
        })
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
            .preferredColorScheme(.dark)
    }
}
