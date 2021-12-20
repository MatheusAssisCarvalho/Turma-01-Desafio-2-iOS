//
//  project_iOS_desafio03App.swift
//  project-iOS-desafio03
//
//  Created by MATHEUS DE ASSIS CARVALHO on 17/12/21.
//

import SwiftUI

@main
struct project_iOS_desafio03App: App {
    var body: some Scene {
        WindowGroup {
            RepoListView(viewModel: RepoListViewModel(githubService: GithubService()))
        }
    }
}
