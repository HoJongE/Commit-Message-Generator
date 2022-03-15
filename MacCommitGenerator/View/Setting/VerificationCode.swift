//
//  VerificationCode.swift
//  MacCommitGenerator
//
//  Created by JongHo Park on 2022/03/08.
//

import SwiftUI

struct VerificationCode: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var authentication: Authentication
    
    var body: some View {
        VStack {
            closeButton
            Text("깃허브 연동")
                .font(.largeTitle)
            GithubImage()
                .padding()
            codeList
            copyButton
            Text("권한을 부여했으면\n인증 확인을 눌러주세요")
                .multilineTextAlignment(.center)
                .font(.headline)
            Button(action: authentication.requestAccessTokenWithDeviceCode) {
                Text("인증 확인")
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 6).fill(Color.background1))
    }
    
    @ViewBuilder
    private var codeList: some View {
        if case let Loadable.success(data: data) = authentication.deviceflowResult {
            HStack(spacing: 8) {
                ForEach(0..<4) {
                    CodeColumn(code: String(data.user_code.getChar(at: $0)))
                }
                Rectangle()
                    .frame(width: 20, height: 2, alignment: .center)
                    .background(Color.gray)
                ForEach(5..<9) {
                    CodeColumn(code: String(data.user_code.getChar(at: $0)))
                }
            }
            .padding()
        } else {
            EmptyView()
        }
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
            }
            .padding()
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var copyButton: some View {
        Button(action: authentication.copyCode) {
            Text("복사 후 열기")
        }
        .buttonStyle(LinkButtonStyle())
        .padding()
    }
}
// MARK: - 코드 글자 데코레이터
extension VerificationCode {
    struct CodeColumn: View {
        let code: String
        var body: some View {
            Text(code)
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).fill(.white))
        }
    }
}
// MARK: - 인증 코드 프리뷰
struct VerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCode()
            .environmentObject(Authentication())
    }
}
