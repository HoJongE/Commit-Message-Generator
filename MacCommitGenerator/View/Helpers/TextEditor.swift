//
//  TextEditor.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct RoundedTextEditor: View {
    
    @State private var showGuide: Bool = false
    @Binding private var text: String
    private let type: EditorType
    private let height: CGFloat
    
    init(_ type: EditorType,_ string: Binding<String>, _ height: CGFloat = 70) {
        self.type = type
        self._text = string
        self.height = height
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.title)
                    .foregroundColor(.text3)
                    .font(.subheadline)
                Button(action: toggleHelperBox) {
                    Image(systemName: "questionmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.brand)
                }
                .zIndex(0)
                .overlay(VStack {
                    if showGuide {
                        helperBox
                            .transition(.scaleAndOpacity)
                    } else {
                        EmptyView()
                    }
                }, alignment: .bottomLeading)
                .buttonStyle(.plain)
            }
            TextEditor(text: $text)
                .border(.gray, width: 1)
                .frame(height: height)
                .onChange(of: text) { newValue in
                    if newValue.count > type.textLimit {
                        text = String(newValue.prefix(type.textLimit))
                    }
                }
            HStack {
                Spacer()
                Text("\(text.count)/\(type.textLimit)")
                    .foregroundColor(.text3)
                    .font(.caption)
            }
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    private var helperBox: some View {
        Text(type.guideText)
            .padding()
            .frame(minWidth: 200, maxWidth:250,minHeight: 50, maxHeight: 150 ,alignment: .topLeading)
            .multilineTextAlignment(.leading)
            .background(RoundedRectangle(cornerRadius: 6).fill(Color.brand))
            .foregroundColor(.white)
            .offset(x: 30, y: 0)
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture(perform: toggleHelperBox)
    }
    
    private func toggleHelperBox() {
        withAnimation(.spring(dampingFraction: 0.5)) {
            showGuide.toggle()
        }
    }
}

extension AnyTransition {
    static var scaleAndOpacity: AnyTransition {
        .scale.combined(with: .opacity).combined(with: .offset(x: -50, y: 50))
    }
}


struct TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedTextEditor(.body,.constant("하이ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ"))
                .preferredColorScheme(.light)
            RoundedTextEditor(.body,.constant("하이"))
                .preferredColorScheme(.dark)
        }
    }
}
