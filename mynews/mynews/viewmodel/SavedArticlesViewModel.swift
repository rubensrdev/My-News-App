//
//  SavedArticlesViewModel.swift
//  mynews
//
//  Created by Ruben on 9/7/24.
//

import Foundation
import CoreData

class SavedArticlesViewModel: ObservableObject {
    @Published var savedArticles: [Article] = []

        init() {
            fetchSavedArticles()
        }

        func fetchSavedArticles() {
            let request: NSFetchRequest<Article> = Article.fetchRequest()
            
            do {
                self.savedArticles = try PersistenceController.shared.container.viewContext.fetch(request)
            } catch {
                print("Error loading saved articles: \(error.localizedDescription)")
            }
        }

        func deleteSavedArticle(at offsets: IndexSet) {
            guard let index = offsets.first else { return }
            let articleToDelete = savedArticles[index]
            
            PersistenceController.shared.container.viewContext.delete(articleToDelete)
            
            do {
                try PersistenceController.shared.saveContext()
                savedArticles.remove(atOffsets: offsets)
            } catch {
                print("Error deleting saved article: \(error.localizedDescription)")
            }
        }
}
