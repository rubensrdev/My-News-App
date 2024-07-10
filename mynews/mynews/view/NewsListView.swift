//
//  NewsListView.swift
//  mynews
//
//  Created by Ruben on 9/7/24.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject private var newsViewModel = NewsViewModel()
    @StateObject private var savedArticleViewModel = SavedArticlesViewModel()
    @State private var isLoading = false
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(newsViewModel.articles) { article in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    Text(article.title)
                                        .font(.headline)
                                    
                                    Text(article.description ?? "")
                                        .font(.subheadline)
                                }
                                VStack {
                                    // Imagen del artículo si está disponible
                                    if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                            case .failure:
                                                EmptyView()
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding()
                        .swipeActions(edge: .trailing) {
                            Button {
                                print("🤖: Save to read later \(article.title)")
                                savedArticleViewModel.saveArticle(title: article.title,
                                                                  url: article.url,
                                                                  imageUrl: article.urlToImage,
                                                                  content: article.content)
                                
                            } label: {
                                Label("Save to read later", systemImage: "bookmark")
                            }
                            .tint(.blue)
                        }
                        .onAppear {
                            // Verificar si se ha llegado al final de la lista
                            if article == newsViewModel.articles.last {
                                loadMoreContentIfNeeded()
                            }
                        }
                    }
                }
                .navigationTitle("Noticias")
                .onAppear {
                    newsViewModel.fetchNews()
                }
            }
        }
    
    private func loadMoreContentIfNeeded() {
        guard !isLoading else { return }
        let thresholdIndex = newsViewModel.articles.count - 1
        
        if thresholdIndex >= (newsViewModel.currentPage - 1) * newsViewModel.pageSize {
                isLoading = true
                newsViewModel.fetchNews()
                isLoading = false
            }
        }
    }

#Preview {
    NewsListView()
}
