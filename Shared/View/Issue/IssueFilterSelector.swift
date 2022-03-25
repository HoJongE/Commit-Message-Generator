//
//  IssueFilter.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/18.
//

import SwiftUI

struct IssueFilterSelector: View {
    @Binding private var selectedFilter: String
    private let icon: Image?
    private let options: [String]
    private let onOptionSelected: (String) -> Void
    
    init(icon: Image? = nil, options: [String], selected: Binding<String>, onOptionSelected: @escaping (String) -> Void) {
        self.icon = icon
        self._selectedFilter = selected
        self.options = options
        self.onOptionSelected = onOptionSelected
    }
    
    var body: some View {
        Menu {
            menuItem
        } label: {
            pickerLabel
        }
        .animation(nil, value: selectedFilter)
        .onChange(of: selectedFilter, perform: onOptionSelected)
    }
    
    private var menuItem: some View {
        ForEach(options, id: \.self) { option in
            Button(action: {selectedFilter = option}) {
                HStack {
                    if option.elementsEqual(selectedFilter) {
                        Image(systemName: "checkmark")
                    }
                    Text(option)
                }
            }
        }
    }
    private var pickerLabel: some View {
        HStack {
            if let icon = icon {
                icon
                    .imageScale(.small)
            }
            Text(selectedFilter)
                .font(.footnote)
            Image(systemName: "chevron.down")
                .imageScale(.small)
        }
        .foregroundColor(.white)
        .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
        .background(RoundedRectangle(cornerRadius: 20).fill(selectedFilter == "All" ? Color.text3 : Color.brand))
    }
}

struct IssueFilterSelector_Previews: PreviewProvider {
    static var previews: some View {
        IssueFilterSelector(icon: Image(systemName: "checkmark"), options: ["All", "123", "234", "345"], selected: .constant("All")) { _ in
        }
        .previewLayout(.sizeThatFits)
    }
}
