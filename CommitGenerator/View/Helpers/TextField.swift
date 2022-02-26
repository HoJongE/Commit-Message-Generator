//
//  TextField.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct RoundedTextField: View {
    let placeholder : String
    var text : Binding<String>
    let showTextCount : Bool
    let textLimit : Int
    
    init(placeholder : String,text : Binding<String>,
         showTextCount :Bool = true,textLimit : Int = 50) {
        self.placeholder = placeholder
        self.text = text
        self.showTextCount = showTextCount
        self.textLimit = textLimit
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack(alignment:.leading){
            Text(placeholder)
                .foregroundColor(.text3)
                .font(.caption)
            TextEditor(text: text)
                .onChange(of: text.wrappedValue) { value in
                    print(text.wrappedValue)
                    if text.wrappedValue.count > textLimit {
                        text.wrappedValue = String(text.wrappedValue.prefix(textLimit))
                    }
                }
                .foregroundColor(.black)
                .frame(minHeight:30,maxHeight: 100)
                .textFieldStyle(PlainTextFieldStyle())
                .lineLimit(1)
                .font(.body)
                
            HStack {
                Spacer()
                Text("\(text.wrappedValue.count)/\(textLimit)")
                    .font(.caption)
                    .foregroundColor(.text2)
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth:.infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(.white))
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField(placeholder : "라벨" ,text: .constant(""))
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
            .preferredColorScheme(.dark)
    }
}
