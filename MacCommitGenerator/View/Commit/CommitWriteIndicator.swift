//
//  CommitWriteIndicator.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/10.
//

import SwiftUI

extension CommitWriteHost {
    struct CommitWriteIndicator: ViewModifier {
        func body(content: Content) -> some View {
            content
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.brand, lineWidth: 2.2), alignment: .center)
        }
    }
}

extension View {
    @ViewBuilder
    func selectIndicator(sameWith viewType: CommitWriteHost.SecondView, current: CommitWriteHost.SecondView) -> some View {
        if viewType == current {
            self.modifier(CommitWriteHost.CommitWriteIndicator())
        } else {
            self
        }
    }
}
