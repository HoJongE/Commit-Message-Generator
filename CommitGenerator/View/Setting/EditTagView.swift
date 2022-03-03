//
//  EditTagView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI

struct EditTagView: View {
    @Environment(\.dismiss) private var dismiss : DismissAction
    private var tag : Tag?
    
    @State private var name : String
    @State private var tagDescription : String
    @State private var color : Color
    
    private let category : String
    
    init(tag : Tag?, category : String) {
        self.tag = tag
        self.category = category
        self._color = State(initialValue: Color(hex: tag?.colorHex ?? "123456"))
        self._name = State(initialValue: tag?.name ?? "")
        self._tagDescription = State(initialValue: tag?.tagDescription ?? "")
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack(alignment:.leading,spacing: 16) {
            HStack(alignment:.lastTextBaseline) {
                Text("이름")
                    .foregroundColor(.text3)
                    .font(.headline).fontWeight(.semibold)
                
                ColorPicker("",selection: $color)

            }
            TextField("이름", text: $name)
                .font(.body)
            Text("설명")
                .foregroundColor(.text3)
                .font(.body).fontWeight(.semibold)
            TextField("설명", text: $tagDescription)
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if nil == tag {
                    Button(action: addTag){
                        Label("추가", systemImage: "plus")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.brand)
                    }
                } else {
                    Button(action: modifyTag){
                        Label("수정", systemImage: "pencil")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.brand)
                    }
                }
            }
        }
        .navigationTitle(tag == nil ? "\(category) 추가" : "\(category) 편집")
    }
    
    
    
    private func modifyTag() {
        guard let tag = tag else {
            return
        }
        tag.name = name
        tag.tagDescription = tagDescription.count == 0 ? nil : tagDescription
        tag.colorHex = color.hexaRGB
        PersistenceController.shared.save()
        dismiss()
    }
    
    private func addTag() {
        guard name.count > 0 else {
            return
        }
        let tag : Tag = Tag(context: PersistenceController.shared.container.viewContext)
        tag.name = name
        tag.tagDescription = tagDescription.count > 0 ? tagDescription : nil
        tag.category = category
        tag.colorHex = color.hexaRGB
        PersistenceController.shared.save()
        dismiss()
    }
}

struct EditTagView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EditTagView(tag: nil,category: "태그")
        }
        .preferredColorScheme(.dark)
    }
}
