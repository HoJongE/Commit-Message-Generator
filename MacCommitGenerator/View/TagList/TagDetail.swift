//
//  TagDetail.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/06.
//

import SwiftUI

struct TagDetail: View {
    private let tag: Tag

    @State private var name: String
    @State private var tagDescription: String
    @State private var color: Color
    @State private var showAlert: Bool = false

    init(_ tag: Tag) {
        self.tag = tag
        self._name = State(initialValue: tag.name ?? "")
        self._tagDescription = State(initialValue: tag.tagDescription ?? "")
        self._color = State(initialValue: Color(hex: tag.colorHex ?? "123456"))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("이름")
                    .font(.title).bold()
                Spacer()
                ColorPicker("", selection: $color)
            }
            TextField("이름", text: $name)

            Text("설명")
                .font(.title).bold()

            TextEditor(text: $tagDescription)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                saveButton
            }
            ToolbarItem(placement: .destructiveAction) {
                deleteButton
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("변경사항 저장이\n완료되었습니다."), message: nil, dismissButton: .default(Text("닫기")))
        }
    }

    private var saveButton: some View {
        Button(action: saveChange) {
            HStack {
                Image("save")
                Text("변경사항 저장")
            }
        }
    }

    private var deleteButton: some View {
        Button {
            withAnimation {
                PersistenceController.shared.delete(tag)
            }
        } label: {
            HStack {
                Image(systemName: "trash.fill")
                Text("삭제")
            }
        }
    }
    
    private func saveChange() {
        showAlert = true
        tag.colorHex = color.hexaRGB
        tag.tagDescription = tagDescription
        tag.name = name
        PersistenceController.shared.save()
    }
}

struct TagDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagDetail(MockedCoreData.shared.tag())
                .preferredColorScheme(.light)
            TagDetail(MockedCoreData.shared.tag())
                .preferredColorScheme(.dark)
        }
    }
}
