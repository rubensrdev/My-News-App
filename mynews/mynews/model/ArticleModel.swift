//
//  ArticleModel.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation

struct ArticleModel: Identifiable, Codable, Equatable {
    
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
        
    struct Source: Codable, Equatable {
        let id: String?
        let name: String
    }
    
    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.source == rhs.source &&
               lhs.author == rhs.author &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.url == rhs.url &&
               lhs.urlToImage == rhs.urlToImage &&
               lhs.publishedAt == rhs.publishedAt &&
               lhs.content == rhs.content
    }
    
}
