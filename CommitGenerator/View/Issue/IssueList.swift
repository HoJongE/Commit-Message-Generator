//
//  IssueList.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import Foundation
import SwiftUI

struct IssueList : View {
    @Environment(\.dismiss) private var dismiss
    let issues : [Issue]
    let addIssue : (Issue) -> Void
    
    var headerView : some View {
            Divider().background(.gray)
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(pinnedViews:[.sectionHeaders]) {
                Section(header:headerView) {
                ForEach(issues,id: \.self) { issue in
                    DetailIssueItem(issue: issue)
                        .onTapGesture {
                            addIssue(issue)
                            dismiss()
                        }
                    if issue.number != issues.last?.number {
                        Divider()
                            .background(Color.gray)
                            .frame(maxWidth:.infinity)
                    }
                }
                }
            }
        }
        .ignoresSafeArea(.all, edges: [.horizontal])
    }
}

struct DetailIssueItem : View {
    let issue : Issue
    @State private var showBody : Bool = false
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment:.center) {
                CircleWebImage(url: issue.user.avatar_url, width: 40)
                VStack(alignment:.leading,spacing: 2) {
                    Text(issue.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(String(issue.repository_url.split(separator: "/").last ?? "") + "  #\(issue.number)")
                        .font(.subheadline)
                        .foregroundColor(.text3)
                }
                .padding(.leading,4)
                Spacer()
                
                Button(action:{
                    withAnimation(.easeInOut) {
                        showBody.toggle()
                    }
                }){
                    Image(systemName: "arrowtriangle.down.circle")
                        .imageScale(.large)
                        .padding(.horizontal,8)
                        .foregroundColor(.brand)
                        .rotationEffect(.degrees(showBody ? 0 : 180))
                }
                
            }
            .padding(12)
            
            if showBody {
                
                Group {
                    Text("본문")
                        .font(.caption)
                        .foregroundColor(.text2)
                        .padding(.leading,12)
                    
                    Text(issue.body ?? "본문이 없습니다.")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.leading,12)
                        .padding(.top,2)
                        .padding(.bottom,8)
                }
                .transition(.slideFromTop)
                
            }
            
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .lineLimit(1)
        
    }
}

extension AnyTransition {
    static var slideFromTop : AnyTransition {
        .opacity.animation(.easeInOut).combined(with: .move(edge: .top))
    }
}

struct Previews_IssueList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailIssueItem(issue: Issue.mocIssue[0])
                .previewLayout(.sizeThatFits)
            IssueList(issues: Issue.mocIssue){_ in}
        }
        .background(Color.background1)
    }
}
