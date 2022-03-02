//
//  TextEditor.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/26.
//

import SwiftUI

struct FullScreenTextEditor<Content:View> : View {
    private let editorType : EditorType
    private let content : () -> Content
    @Binding private var text : String
    @State private var showGuide : Bool = false

    
    init(editorType:  EditorType,text : Binding<String>,
    @ViewBuilder content :@escaping () -> Content) {
        self.editorType = editorType
        self._text = text
        self.content = content
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack (alignment:.leading,spacing:16){
            content()
            VStack(alignment:.leading,spacing: 0) {
                GuideButton(showGuide: $showGuide)
                Divider().padding(.horizontal)
                if showGuide {
                    GuideBox(content: editorType.guideText)
                }
                TextEditor(text: $text)
                    .onChange(of: text,perform: constraintTextLength(value:))
                    .foregroundColor(.black)
                    .background(Color.white)
                    .padding(.horizontal,12)
                HStack{
                    Spacer()
                    Text("\(text.count)/\(editorType.textLimit)")
                        .foregroundColor(.text3)
                        .font(.caption)
                        .padding()
                }
                
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 6).fill(.white))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ResetButton {
                    text = ""
                }
            }
        }
        .padding()
        .navigationTitle(editorType.title)
        
    }
    
    func constraintTextLength(value : String) {
        if text.count > editorType.textLimit {
            text = String(text.prefix(editorType.textLimit))
        }
    }
}

struct GuideButton : View {
    @Binding var showGuide: Bool
    
    var body: some View {
        Button(action:onTap)
        {
            Label("도움말 보기", systemImage: "questionmark.circle.fill")
                .labelStyle(.titleAndIcon)
                .font(.subheadline)
                
        }
        .padding(.horizontal,16)
        .padding(.vertical,12)
        .background(.white)
        .cornerRadius(6, corners: .topLeft)
        .cornerRadius(6, corners: .topRight)
    
        
    }
    
    private func onTap() {
        withAnimation(.easeInOut){
            showGuide.toggle()
        }
    }
}

struct ResetButton : View {
    let onClick : ()->Void
    var body: some View {
        Button(action:onClick) {
            Label("삭제", systemImage: "trash")
                .labelStyle(.titleAndIcon)
        }
    }
}

struct GuideBox : View {
    let content : String
    var body: some View {
        Text(content)
            .font(.caption)
            .foregroundColor(.text2)
            .padding(.horizontal)
            .padding(.vertical,4)
            .foregroundColor(.white)
            .frame(maxWidth:.infinity,alignment: .topLeading)
            .multilineTextAlignment(.leading)
    }
}


struct TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ForEach(PreviewDevice.mock,id: \.self) {
                NavigationView {
                    FullScreenTextEditor(editorType: .Title, text: .constant("")){Text("안녕 ㅎㅎ")}
                }
                .previewDevice(PreviewDevice(rawValue: $0))
            }
        }
        .preferredColorScheme(.dark)
    }
}


