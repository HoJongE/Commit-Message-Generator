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
    func getIssues(_ page: Int) -> AnyPublisher<Lodable<[Issue]>, Never>
    func getUser() -> AnyPublisher<Lodable<User>, Never>
    func deviceflow() -> AnyPublisher<Lodable<DeviceflowResult>, Never>
    func closeIssue(_ issue: Issue)
    
}
// MARK: - 깃허브 인스턴스
final class GithubService {
    static let shared: GithubService = GithubService()

    private init() {}
}
// MARK: - 깃허브 서비스 프로토콜 구현 부분
extension GithubService : GithubServiceProtocol {
    
    func deviceflow() -> AnyPublisher<Lodable<DeviceflowResult>, Never> {
        let url: String = Const.URL.GITHUB_DEVICE_FLOW
        let headers: HTTPHeaders = ["Accept": "application/json"]
        let paramteters: Parameters = ["client_id": Const.GitHub.CLIEND_ID,
                                       "scope": "repo,user"]
        
        return AF.request(url, method: .post, parameters: paramteters, headers: headers)
            .publishDecodable(type: DeviceflowResult.self)
            .value()
            .map {
                Lodable.success(data: $0)
            }
            .catch { (error) -> AnyPublisher<Lodable<DeviceflowResult>, Never> in
                Just(Lodable.error(error: error)).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getUser() -> AnyPublisher<Lodable<User>, Never> {
        let url: String = Const.URL.GITHUB_USER
        let accessToken: String? = KeyChainManager.shared.readToken()
        
        guard let accessToken = accessToken else {
            return Just(Lodable.error(error: NetworkError.authenticationError))
                .eraseToAnyPublisher()
        }

        let headers: HTTPHeaders = ["accept": "application/vnd.github.v3+json",
                                     "Authorization": "token \(accessToken)"]

        return AF.request(url,
                   method: .get,
                   headers: headers)
            .publishDecodable(type: User.self)
            .value()
            .map {
                Lodable.success(data: $0)
            }
            .catch {
                Just(Lodable.error(error: $0))
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getIssues(_ page: Int) -> AnyPublisher<Lodable<[Issue]>, Never> {
        let url: String = Const.URL.GITHUB_ISSUE
        let accessToken: String? = KeyChainManager.shared.readToken()

        guard let accessToken = accessToken else {
            return Just(Lodable.error(error: NetworkError.authenticationError))
                .eraseToAnyPublisher()
        }

        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken)"]
        let parameters: Parameters = ["state": "open", "per_page": 100, "page": page]
        
        return AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .publishDecodable(type: [Issue].self)
            .value()
            .map {
                Lodable.success(data: $0)
            }
            .catch {
                Just(Lodable.error(error: $0))
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
        let url: String = Const.URL.GITHUB_BASE_URL + "/repos/\(issue.user.login)/\(issue.repository.lowercased())/issues/\(issue.number)"
        
        let headers: HTTPHeaders = ["accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken)"]
        
        let parameters: Parameters = ["state": "closed"]
        
        _ = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding(), headers: headers)
    }
}
