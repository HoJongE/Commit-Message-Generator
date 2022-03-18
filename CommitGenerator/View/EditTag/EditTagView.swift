//
//  EditTagView.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/02.
//

import SwiftUI
// MARK: - 편집 태그 뷰
struct EditTagView: View {
    @EnvironmentObject private var tagViewModel: TagViewModel
    @Environment(\.dismiss) private var dismiss: DismissAction
    private var tag: Tag?

    @State private var name: String
    @State private var tagDescription: String
    @State private var color: Color

    private let category: String

    init(tag: Tag?, category: String) {
        self.tag = tag
        self.category = category
        self._color = State(initialValue: Color(hex: tag?.colorHex ?? "123456"))
        self._name = State(initialValue: tag?.name ?? "")
        self._tagDescription = State(initialValue: tag?.tagDescription ?? "")
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .lastTextBaseline) {
                Text("이름")
                    .foregroundColor(.text3)
                    .font(.headline).fontWeight(.semibold)
                ColorPicker("", selection: $color)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .navigationTitle(tag == nil ? "\(category) 추가" : "\(category) 편집")
        .toolbar(content: toolbar)
    }
}
// MARK: - 툴바 모음
extension EditTagView {
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if nil == tag {
                Button(action: addTag) {
                    Label("추가", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                        .foregroundColor(.brand)
                }
            } else {
                Button(action: modifyTag) {
                    Label("수정", systemImage: "pencil")
                        .labelStyle(.titleAndIcon)
                        .foregroundColor(.brand)
                }
            }
        }
    }
}
// MARK: - 태그 편집, 추가 기능
extension EditTagView {
    private func modifyTag() {
        guard let tag = tag else {
            return
        }
        tagViewModel.modifyTag(change: tag, name: name, color: color.hexaRGB ?? "#123456", description: tagDescription)
        dismiss()
    }

    private func addTag() {
        tagViewModel.addTag(name: name, colorHex: color.hexaRGB ?? "#123456", tagDescription: tagDescription, category: category)
        dismiss()
    }
}
// MARK: - 태그 편집 프리뷰
struct EditTagView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditTagView(tag: nil, category: "태그")
        }
        .preferredColorScheme(.dark)
    }
}
