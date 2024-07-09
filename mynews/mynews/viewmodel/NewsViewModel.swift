//
//  NewsViewModel.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    
    @Published var articles: [ArticleModel] = []
    private let newsAPI = NewsAPI()
    private var cancellables = Set<AnyCancellable>()
    var currentPage = 1
    let pageSize = 10
    
    init() {
        fetchNews()
    }

    func fetchNews() {
        print("🤖: Fetch news execute... ")
        newsAPI.fetchNews(page: currentPage, pageSize: pageSize)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("🤖: Error fetching news: \(error)")
                }
            }, receiveValue: { articles in
                self.articles.append(contentsOf: articles)
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
    
}
