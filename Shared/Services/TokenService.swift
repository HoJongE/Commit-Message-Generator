//
//  GithubService.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import Alamofire
import Combine
// MARK: - 토큰 서비스 프로토콜
protocol TokenServiceProtocol {
    func requestAccessToken(with code: String) -> AnyPublisher<Loadable<String>, Never>
    func requestAccessTokenWithDeviceflow(with code: String) -> AnyPublisher<Loadable<String>, Never>
}
// MARK: - 토큰 서비스 인스턴스
final class TokenService {
    static let shared: TokenService = TokenService()
    
    private init() {}
}
// MARK: - 토큰 서비스 API 콜
extension TokenService {
    enum API {
        case accessToken(code: String)
        case accessTokenWithDeviceflow(code: String)
    }
}
extension TokenService.API: APICall {
    var path: String {
        Const.URL.GITHUB_ACCESS_TOKEN
    }
    var method: HTTPMethod {
        .post
    }
    var headers: HTTPHeaders? {
        ["Accept": "application/json"]
    }
    var parameters: Parameters? {
        switch self {
        case .accessToken(code: let code):
            return ["client_id": Const.GitHub.CLIEND_ID,
                    "client_secret": Const.GitHub.CLIENT_SECRET,
                    "code": code]
        case .accessTokenWithDeviceflow(code: let code):
            return ["client_id": Const.GitHub.CLIEND_ID,
                    "device_code": code,
                    "grant_type": "urn:ietf:params:oauth:grant-type:device_code"]
        }
    }
}
// MARK: - 토큰 서비스 프로토콜 구현부분
extension TokenService: TokenServiceProtocol {
    func requestAccessToken(with code: String) -> AnyPublisher<Loadable<String>, Never> {
        return TokenService.API.accessToken(code: code)
            .request(baseURL: Const.URL.GITHUB_AUTHENTICATE_BASE_URL)
            .publishResponse(using: DecodableResponseSerializer<[String: String]>())
            .map {
                switch $0.result {
                case let .success(dic):
                    return Loadable.success(data: dic["access_token"]!)
                case let .failure(error):
                    return Loadable.error(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestAccessTokenWithDeviceflow(with code: String) -> AnyPublisher<Loadable<String>, Never> {
        return TokenService.API.accessTokenWithDeviceflow(code: code)
            .request(baseURL: Const.URL.GITHUB_AUTHENTICATE_BASE_URL)
            .publishResponse(using: DecodableResponseSerializer<[String: String]>())
            .map {
                switch $0.result {
                case let .success(dic):
                    return Loadable.success(data: dic["access_token"]!)
                case let .failure(error):
                    return Loadable.error(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
