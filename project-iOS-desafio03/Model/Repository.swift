//
//  Repository.swift
//  desafio3-formacaoiOS
//
//  Created by MATHEUS DE ASSIS CARVALHO on 16/12/21.
//

import Foundation

public struct Repository: Decodable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case updateAt = "updated_at"
        case createdAt = "created_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case description = "description"
        case owner = "owner"
    }
    
    public let id: Int
    let name: String
    let fullName: String
    let updateAt: String
    let createdAt: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let description: String?
    let owner: Owner
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        fullName = try values.decode(String.self, forKey: .fullName)
        updateAt = try values.decode(String.self, forKey: .updateAt)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        stargazersCount = try values.decode(Int.self, forKey: .stargazersCount)
        watchersCount = try values.decode(Int.self, forKey: .watchersCount)
        forksCount = try values.decode(Int.self, forKey: .forksCount)
        description = try? values.decode(String.self, forKey: .description)
        owner = try values.decode(Owner.self, forKey: .owner)
        
    }
    
}
