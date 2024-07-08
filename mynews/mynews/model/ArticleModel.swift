//
//  ArticleModel.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation

struct ArticleModel: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var url: String
    var isReadLater: Bool = false
}
