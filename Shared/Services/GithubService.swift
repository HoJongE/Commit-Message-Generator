//
//  GithubService.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import Alamofire
import Combine
// MARK: - 프로토콜 선언 부분
protocol GithubServiceProtocol {
    func getIssues(_ page: Int) -> AnyPublisher<Loadable<[Issue]>, Never>
    func getUser() -> AnyPublisher<Loadable<User>, Never>
    func closeIssue(_ issue: Issue)
    
}
// MARK: - 깃허브 인스턴스
final class GithubService {
    static let shared: GithubService = GithubService()

    private init() {}
}
// MARK: - 깃허브 서비스 API CALL 구현
extension GithubService {
    enum API {
        case issues(code: String)
        case user(code: String)
        case deviceflow
        case closeIssue(issue: Issue, code: String)
    }
}

extension GithubService.API: APICall {
    var method: HTTPMethod {
        switch self {
        case .issues: return .get
        case .user: return .get
        case .deviceflow: return .post
        case .closeIssue: return .patch
        }
    }
    var path: String {
        switch self {
        case .closeIssue(issue: let issue, _):
            return "/repos/\(issue.organization)/\(issue.repository)/issues/\(issue.number)"
        case .deviceflow:
            return Const.URL.GITHUB_DEVICE_FLOW
        case .issues:
            return Const.URL.GITHUB_ISSUE
        case .user:
            return Const.URL.GITHUB_USER
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .user:
            return nil
        case .issues:
            return ["state": "open", "per_page": 100, "page": 1]
        case .deviceflow:
            return ["client_id": Const.GitHub.CLIEND_ID,
                    "scope": "repo,user"]
        case .closeIssue:
            return ["state": "closed"]
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .closeIssue(_, let code):
            return ["accept": "application/vnd.github.v3+json",
                                        "Authorization": "token \(code)"]
        case .deviceflow:
            return  ["Accept": "application/json"]
        case .user(let code):
            return ["accept": "application/vnd.github.v3+json",
                                         "Authorization": "token \(code)"]
        case .issues(let code):
            return ["Accept": "application/vnd.github.v3+json",
                                        "Authorization": "token \(code)"]
        }
    }
}
// MARK: - 깃허브 서비스 프로토콜 구현 부분
extension GithubService: GithubServiceProtocol {

    func getUser() -> AnyPublisher<Loadable<User>, Never> {
        let accessToken: String? = KeyChainManager.shared.readToken()
        
        guard let accessToken = accessToken else {
            return Just(Loadable.error(error: NetworkError.authenticationError))
                .eraseToAnyPublisher()
        }

        return GithubService.API.user(code: accessToken).request(baseURL: Const.URL.GITHUB_BASE_URL)
            .publishDecodable(type: User.self)
            .value()
            .map {
                Loadable.success(data: $0)
            }
            .catch {
                Just(Loadable.error(error: $0))
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getIssues(_ page: Int) -> AnyPublisher<Loadable<[Issue]>, Never> {
        let accessToken: String? = KeyChainManager.shared.readToken()

        guard let accessToken = accessToken else {
            return Just(Loadable.error(error: NetworkError.authenticationError))
                .eraseToAnyPublisher()
        }
        
        return GithubService.API.issues(code: accessToken)
            .request(baseURL: Const.URL.GITHUB_BASE_URL)
            .publishDecodable(type: [Issue].self)
            .value()
            .map {
                Loadable.success(data: $0)
            }
            .catch {
                Just(Loadable.error(error: $0))
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeIssue(_ issue: Issue) {
        let accessToken: String? = KeyChainManager.shared.readToken()
        guard let accessToken = accessToken else {
            return
        }
        GithubService.API.closeIssue(issue: issue, code: accessToken).request(baseURL: Const.URL.GITHUB_BASE_URL, encoding: JSONEncoding())
            .responseData { data in
                print(data.result)
                print(data)
                print(data.debugDescription)
            }
    }
}
