//
//  ContentView.swift
//
//  Created by MATHEUS DE ASSIS CARVALHO on 15/12/21.
//

import SwiftUI
import RxSwift
import SDWebImageSwiftUI

struct RepoListView: View {
    
    @StateObject var viewModel: RepoListViewModel
    
    
    var body: some View {
        NavigationView {
            List (self.viewModel.repositories) { repository in
                NavigationLink(destination: RepoDetailView(viewModel: RepoDetailViewModel(repository: repository, githubService: GithubService()))) {
                    HStack {
                        WebImage(url: URL(string: repository.owner.avatar_url))
                            .placeholder(Image(systemName: "photo"))
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .scaledToFit()
                            .frame(height: 100)
                            .cornerRadius(4)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(repository.name)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Text("Author: \(repository.owner.login)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(repository.description ?? "...")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                            Text("Stars: \(repository.stargazersCount)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Forks: \(repository.forksCount)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onAppear(perform: {
                    viewModel.loadMoreContentIfNeeded(currentItem: repository)
                })
                if viewModel.isLoadingPage {
                    ProgressView()
                }
            }
            .navigationTitle("GitHub Swift Repo")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(viewModel: RepoListViewModel(githubService: GithubService()))
    }
}
