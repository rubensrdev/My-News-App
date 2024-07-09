//
//  NewsResponseModel.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation

struct NewsResponseModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [ArticleModel]
}
