//
//  NewsAPI.swift
//  mynews
//
//  Created by Ruben on 9/7/24.
//

import Foundation
import Combine

class NewsAPI {
    private let apiKey = "39237385292b466495aa29bbdcc29bc4"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    func fetchNews(page: Int, pageSize: Int) -> AnyPublisher<[ArticleModel], Error> {
        let url = URL(string: "\(baseURL)?country=us&apiKey=\(apiKey)&page=\(page)&pageSize=\(pageSize)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: NewsResponseModel.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
