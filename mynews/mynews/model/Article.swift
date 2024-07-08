//
//  Article.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import Foundation

struct Article: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var url: String
    var isReadLater: Bool = false
}
