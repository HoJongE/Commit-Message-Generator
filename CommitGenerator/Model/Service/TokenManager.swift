//
//  GithubService.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import Alamofire

class TokenManager  {
    static let shared = TokenManager()
    
    func requestAccessToken(with code: String, _ completion : @escaping (Lodable<String>) -> Void = {_ in}) {
        let url = Const.URL.GITHUB_ACCESS_TOKEN
        let parameters = ["client_id": Const.GitHub.CLIEND_ID,
                          "client_secret": Const.GitHub.CLIENT_SECRET,
                          "code": code]
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { (response) in
            switch response.result {
                case let .success(json):
                    if let dic = json as? [String: String] {
                        completion(Lodable.Success(data: dic["access_token"]!))
                    } else {
                        completion(Lodable.Error(error: NetworkError.authenticationError))
                    }
                case let .failure(error):
                    completion(Lodable.Error(error: error))
            }
        }
    }
}
