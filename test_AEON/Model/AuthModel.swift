//
//  AuthModel.swift
//  test_AEON
//
//  Created by Andrey on 22.10.2021.
//

import Foundation

// MARK: - AuthModel
struct AuthModel: Codable {
    let success: String
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let token: String
}
