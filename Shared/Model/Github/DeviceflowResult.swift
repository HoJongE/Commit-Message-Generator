//
//  DeviceflowResult.swift
//  CommitGenerator
//
//  Created by JongHo Park on 2022/03/08.
//

import Foundation

struct DeviceflowResult: Codable {
    let device_code: String
    let user_code: String
    let verification_uri: String
    let expires_in: Int
    let interval: Int
}

extension DeviceflowResult: CustomStringConvertible {
    var description: String {
        "device_code:\(device_code) verification_url:\(verification_uri)"
    }
}
