//
//  UserPublishig.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation

public struct UserPublishig: Codable, Hashable {
    let userID: Int
    let id: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
