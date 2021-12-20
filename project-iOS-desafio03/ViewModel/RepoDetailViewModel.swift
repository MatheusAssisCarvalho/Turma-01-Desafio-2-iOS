//
//  RepoDetailViewModel.swift
//  project-iOS-desafio03
//
//  Created by MATHEUS DE ASSIS CARVALHO on 18/12/21.
//

import RxSwift

class RepoDetailViewModel : ObservableObject {
    private let githubService: GithubService

    @Published var repository: Repository!
    
    @Published var name = ""
    @Published var stargazers = ""

    @Published var commits = ""
    @Published var releases = ""
    @Published var branches = ""
    @Published var colaborators = ""
    @Published var pullRequest: [PullRequest] = []
    
    init(repository: Repository, githubService: GithubService) {
        self.repository = repository
        self.githubService = githubService
        
        name = repository.fullName
        stargazers = "\(repository.stargazersCount)"

        fetchDataFromGithubApi()
    }
    
    private func fetchDataFromGithubApi() {
        githubService.getBranchesOf(repository) { [weak self] result in
            switch result {
            case .success(let branches):
                self?.branches = "\(branches.count)"
            default:
                self?.branches = "..."
            }
        }

        githubService.getReleasesOf(repository) { [weak self] result in
            switch result {
            case .success(let releases):
                self?.releases = "\(releases.count)"
            default:
                self?.releases = "..."
            }
        }

        githubService.getContributorsOf(repository) { [weak self] result in
            switch result {
            case .success(let contributors):
                self?.colaborators = "\(contributors.count)"
                self?.commits = String(contributors.map { $0.contributions }.reduce(0, +))
            default:
                self?.colaborators = "..."
                self?.commits = "..."
            }
        }
        
        githubService.getPullRequestOf(repository) { [weak self] result in
            switch result {
            case .success(let pullRequest):
                self?.pullRequest = pullRequest
            default:
                self?.pullRequest = []
            }
        }
    }
    
    
}
