//
//  AddTag.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/07.
//

import SwiftUI

struct AddTag: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @State private var tagDescription: String = ""
    @State private var color: Color = .brand
    @State private var category: Category = .tag
    @State private var showAlert: Bool = false
    enum Category:String, CaseIterable {
        case tag = "태그"
        case function = "기능"
    }
    var body: some View {
        VStack(alignment:.leading) {
            HStack(spacing: 24) {
                Text("이름")
                    .font(.title).bold()
                Picker("카테고리", selection: $category) {
                    Text("태그").tag(Category.tag)
                    Text("기능").tag(Category.function)
                }
                ColorPicker("", selection: $color)
            }
            TextField("태그 이름", text: $name)
            
            Text("설명")
                .font(.title).bold()
            TextEditor(text: $tagDescription)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("이름을 입력해주세요"), message: nil, dismissButton: .default(Text("닫기")))
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                saveButton
            }
        }
        .navigationTitle("태그 추가")
        .padding()
        .frame(width:350 ,alignment: .topLeading)
    }
    
    private var saveButton: some View {
        Button {
            addTag()
        } label: {
            Image("save")
        }
        .offset(y: 8)
    }
    
    private func addTag() {
        guard !name.isEmpty else {
            showAlert = true
            return
        }
        
        let tag: Tag = Tag(context: PersistenceController.shared.container.viewContext)
        
        tag.name = name
        tag.tagDescription = tagDescription.isEmpty ? nil : tagDescription
        tag.category = category.rawValue
        tag.colorHex = color.hexaRGB
        
        PersistenceController.shared.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddTag_Previews: PreviewProvider {
    static var previews: some View {
        AddTag()
    }
}
