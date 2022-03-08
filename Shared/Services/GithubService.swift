//
//  GithubService.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import Alamofire

final class GithubService {
    static let shared: GithubService = GithubService()

    private init() {}

    func getIssues(_ page: Int, _ completion : @escaping (Lodable<[Issue]>) -> Void = {_ in}) {
        let url: String = Const.URL.GITHUB_ISSUE
        let accessToken: String? = KeyChainManager.shared.readToken()

        guard let accessToken = accessToken else {
            completion(Lodable.error(error: NetworkError.authenticationError))
            return
        }

        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken)"]
        let parameters: Parameters = ["state": "open", "per_page": 100, "page": page]

        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseData { result in

            guard let response = result.response, let value = result.value else {
                completion(Lodable.error(error: NetworkError.responseNotExist))
                return
            }

            if let error = self.judgeStatus(response.statusCode) {
                completion(Lodable.error(error: error))
                return
            }

            do {
                let issues: [Issue] = try JSONDecoder().decode([Issue].self, from: value)
                completion(Lodable.success(data: issues))

            } catch {
                completion(Lodable.error(error: error))
            }
        }
    }

    func getUser(completion :@escaping (Lodable<User>) -> Void = {_ in}) {
        let url: String = Const.URL.GITHUB_USER
        let accessToken: String? = KeyChainManager.shared.readToken()
        guard let accessToken = accessToken else {
            completion(Lodable.error(error: NetworkError.authenticationError))
            return
        }

        let headers: HTTPHeaders = ["accept": "application/vnd.github.v3+json",
                                     "Authorization": "token \(accessToken)"]

        AF.request(url,
                   method: .get,
                   headers: headers).responseData { result in

            guard let response = result.response, let value = result.value else {
                completion(Lodable.error(error: NetworkError.responseNotExist))
                return
            }

            if let error = self.judgeStatus(response.statusCode) {
                completion(Lodable.error(error: error))
                return
            }

            do {
                let user: User = try JSONDecoder().decode(User.self, from: value)
                completion(Lodable.success(data: user))
            } catch {
                completion(Lodable.error(error: error))
            }

        }

    }

    private func judgeStatus(_ statusCode: Int) -> Error? {
        switch statusCode {
            case 200: return nil
            case 304: return NetworkError.error304
            case 404: return NetworkError.error404
            case 422: return NetworkError.error422
            default: return NetworkError.responseNotExist
        }
    }
    
    func deviceflow(completion: @escaping (Lodable<DeviceflowResult>) -> Void) {
        let url: String = Const.URL.GITHUB_DEVICE_FLOW
        let headers: HTTPHeaders = ["Accept": "application/json"]
        let paramteters: Parameters = ["client_id": Const.GitHub.CLIEND_ID,
                                       "scope": "repo,user"]
        AF.request(url,
                   method: .post,
                   parameters: paramteters
                   ,headers: headers).responseData { result in
            print(result.description)
            guard let response = result.response, let value = result.value else {
                completion(Lodable.error(error: NetworkError.responseNotExist))
                return
            }
            
            if let error = self.judgeStatus(response.statusCode) {
                completion(Lodable.error(error: error))
                return
            }
            
            do {
                let deviceflowResult: DeviceflowResult = try JSONDecoder().decode(DeviceflowResult.self, from: value)
                completion(Lodable.success(data: deviceflowResult))
            } catch {
                completion(Lodable.error(error: error))
            }
        }
        
    }
}
