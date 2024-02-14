//
//  RepublikaNews.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 14/02/24.
//

import SwiftUI

struct RepublikaNews: View {
    @StateObject private var newsVM = NewsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(newsVM.articles) { article in
                            NavigationLink(destination: SafariView(url: URL(string: article.link)!)) {
                                HorizontalCardView(article: article)
                            }
                        }
                    }
                    .padding()
                }
                
                List(newsVM.articles) { article in
                    NavigationLink(destination: SafariView(url: URL(string: article.link)!)) {
                        CardView(article: article)
                    }

                }
                
                .navigationTitle(Constant.ViewTitles.newsTitle)
                .task {
                    await newsVM.loadNews()
                }
                .overlay {
                    switch newsVM.loadingOverlay {
                    case .loading:
                        ProgressView().scaleEffect(2)
                    case .error(let message):
                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.red)
                    case .none:
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    RepublikaNews()
}
