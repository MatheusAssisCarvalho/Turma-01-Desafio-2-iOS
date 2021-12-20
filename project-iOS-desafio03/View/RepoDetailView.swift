//
//  RepoDetailView.swift
//
//  Created by MATHEUS DE ASSIS CARVALHO on 15/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepoDetailView: View {
    
    @StateObject var viewModel: RepoDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: viewModel.repository.owner.avatar_url))
                    .placeholder(Image(systemName: "photo"))
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text(self.viewModel.repository.name)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Total de estrelas")
                    Text(self.viewModel.stargazers)
                }
            }
            HStack {
                VStack (alignment: .leading) {
                    Text("Commits")
                        .font(.subheadline)
                    Text(self.viewModel.commits)
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Releases")
                        .font(.subheadline)
                    Text(self.viewModel.releases)
                        .font(.subheadline)
                }
            }
            HStack {
                VStack (alignment: .leading) {
                    Text("Branches")
                        .font(.subheadline)
                    Text(self.viewModel.branches)
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Colaborators")
                        .font(.subheadline)
                    Text(self.viewModel.colaborators)
                        .font(.subheadline)
                }
            }
            List (self.viewModel.pullRequest) { pr in
                Link(destination: URL(string: "https://github.com/\(viewModel.repository.fullName)/pull/\(pr.number)")!) {
                    HStack {
                        WebImage(url: URL(string: pr.user.avatar_url))
                            .placeholder(Image(systemName: "photo"))
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .scaledToFit()
                            .frame(height: 80)
                            .cornerRadius(4)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(pr.title)")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Text("Author: \(pr.user.login)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Date: \(pr.updated_at)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Body: \(pr.body)")
                                .fontWeight(.light)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(5)
                        }
                    }
                }
            }
        }
        .padding(30)
    }
}

//struct RepoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let githubService = GithubService()
//        
//        RepoDetailView(viewModel: RepoDetailViewModel(repository: Repository, githubService: GithubService()))
//    }
//}
