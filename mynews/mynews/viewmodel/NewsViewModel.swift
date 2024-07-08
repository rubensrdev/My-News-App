//
//  NewsViewModel.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation
import Combine

class NewsViewModel {
    
    @Published var articles: [ArticleModel] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "" // TODO add API KEY
    
    init() {
        fetchNews()
    }

    func fetchNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_API_KEY")! // TODO add Query
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsResponseModel.self, decoder: JSONDecoder())
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.articles, on: self)
            .store(in: &cancellables)
    }
    
}
