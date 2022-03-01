//
//  BottomSheetContainer.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/03/01.
//

import SwiftUI

struct BottomSheetContainer: View {
    
    @EnvironmentObject var bottomSheetManager : BottomSheetManager
    @Environment(\.dismiss) var dismiss : DismissAction
    
    var body: some View {
        VStack {
            HStack {
                Text(bottomSheetManager.action.rawValue)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Button(action:{dismiss()}) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
            }
            switch bottomSheetManager.action {
                case .GithubLogin:
                    GithubLoginView {dismiss()}
                default: EmptyView()
            }
            
            Spacer()
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .padding()
        .background(Color.background1.edgesIgnoringSafeArea(.all))
    }
}

struct BottomSheetContainer_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContainer()
            .environmentObject(BottomSheetManager())
    }
}
