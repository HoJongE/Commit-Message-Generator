//
//  GithubService.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation
import Alamofire

final class GithubService {
    static let shared = GithubService()
    
    private init(){}
    
    func getIssues(_ page : Int,_ completion : @escaping (Lodable<[Issue]>) -> Void = {_ in}){
        let url = Const.URL.GITHUB_ISSUE
        let accessToken = KeyChainManager.shared.readToken()
        guard let accessToken = accessToken else {
            completion(Lodable.Error(error: NetworkError.authenticationError))
            return
        }

        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization":"token \(accessToken)"]
        let parameters: Parameters = ["state":"open","per_page":100,"page":page]
        
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseData { result in
            
            guard let response = result.response,let value = result.value else {
                completion(Lodable.Error(error: NetworkError.ResponseNotExist))
                return
            }
            
            if let error = self.judgeStatus(response.statusCode) {
                completion(Lodable.Error(error: error))
                return
            }
            
            do {
                let issues = try JSONDecoder().decode([Issue].self, from: value)
                completion(Lodable.Success(data: issues))
                
            } catch {
                completion(Lodable.Error(error: error))
            }
        }
    }
    
    func getUser(completion :@escaping (Lodable<User>) -> Void = {_ in}) {
        let url = Const.URL.GITHUB_USER
        let accessToken = KeyChainManager.shared.readToken()
        guard let accessToken = accessToken else {
            completion(Lodable.Error(error: NetworkError.authenticationError))
            return
        }
        
        let headers : HTTPHeaders = ["accept":"application/vnd.github.v3+json",
                                     "Authorization":"token \(accessToken)"]
        
        AF.request(url,
                   method: .get,
                   headers: headers).responseData { result in
            
            guard let response = result.response,let value = result.value else {
                completion(Lodable.Error(error: NetworkError.ResponseNotExist))
                return
            }
            
            if let error = self.judgeStatus(response.statusCode) {
                completion(Lodable.Error(error: error))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: value)
                completion(Lodable.Success(data: user))
            } catch {
                completion(Lodable.Error(error: error))
            }

        }

    }
    
    private func judgeStatus(_ statusCode : Int) -> Error? {
        switch statusCode {
            case 200: return nil
            case 304: return NetworkError.Error304
            case 404: return NetworkError.Error404
            case 422: return NetworkError.Error422
            default: return NetworkError.ResponseNotExist
        }
    }
}