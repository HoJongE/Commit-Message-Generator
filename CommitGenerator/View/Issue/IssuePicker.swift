//
//  IssuePicker.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import SwiftUI

struct IssuePicker: View {
    
    let issueType : IssueType
    let issueAdd : (Issue) -> Void
    @State private var issueNumber : String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment:.center){
            TextField("이슈번호", text: $issueNumber)
                .padding()
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            Button("추가") {
                let issue = Issue(Int(issueNumber)!, issueType)
                issueAdd(issue)
                dismiss()
            }
            .disabled(issueNumber.count == 0)
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.background1.edgesIgnoringSafeArea(.all))
        .navigationTitle(issueType.rawValue)
    }
}

struct IssuePicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IssuePicker(issueType: .Ref){_ in}
        }
        .preferredColorScheme(.dark)
    }
}
