//
//  PullRequest.swift
//  project-iOS-desafio03
//
//  Created by MATHEUS DE ASSIS CARVALHO on 18/12/21.
//


public struct PullRequest: Decodable, Identifiable {
    public let id: Int
    let title: String
    let number: Int
    let user: User
    let body: String
    let updated_at: String
}
