//
//  SavedArticlesViewModel.swift
//  mynews
//
//  Created by Ruben on 9/7/24.
//

import Foundation
import CoreData

class SavedArticlesViewModel: ObservableObject {
    @Published var savedArticles: [ArticleModel] = []
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchSavedArticles()
    }

    func fetchSavedArticles() {
        // Implementar la lógica para obtener datos de Core Data
    }

    func markAsRead(article: ArticleModel) {
        // Implementar la lógica para marcar como leída y actualizar Core Data
    }
}
