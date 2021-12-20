//
//  RepoListViewModel.swift
//
//  Created by MATHEUS DE ASSIS CARVALHO on 16/12/21.
//
//

import RxSwift
import RxCocoa
import Combine

class RepoListViewModel : ObservableObject {
    
    private let githubService: GithubService
    let filterService: FilterService
    
    let searchQuery = BehaviorSubject(value: "")
    @Published var repositories: [Repository] = []
    
    @Published var isLoadingPage = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init (githubService: GithubService) {
        self.githubService = githubService
        self.filterService = FilterService.shared
        search()
    }
    
    func search () {
        guard var query = try? searchQuery.value() else {
            return
        }
        
        if query.isEmpty {
            query = "language:swift"
        }
        
        githubService.searchRepositories(query: query, sorting: FilterService.shared.sorting, order: FilterService.shared.order, page: currentPage) { [self] result in
            
            switch result {
            case .success(let response):
                self.repositories = self.repositories + response.repositories
                self.isLoadingPage = false
                self.currentPage += 1
                
            default:
                self.repositories = []
            }
        }
    }
    
    func loadMoreContentIfNeeded(currentItem item: Repository?) {
        guard let item = item else {
          loadMoreContent()
          return
        }

        let thresholdIndex = repositories.index(repositories.endIndex, offsetBy: -5)
        if repositories.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
          loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
          return
        }
        isLoadingPage = true
        search()
      }
}
