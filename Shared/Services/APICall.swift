//
//  APICall.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/14.
//

import Foundation
import Alamofire

protocol APICall {
    var path: String {get}
    var method: HTTPMethod {get}
    var headers: HTTPHeaders? {get}
    var parameters: Parameters? {get}
}

extension APICall {
    func request(baseURL: String, encoding: ParameterEncoding? = nil) -> DataRequest {
        if let encoding = encoding {
            return AF.request(baseURL + path, method: method, parameters: parameters, encoding: encoding, headers: headers)
        } else {
            return AF.request(baseURL + path, method: method, parameters: parameters, headers: headers)
        }
    }
}
