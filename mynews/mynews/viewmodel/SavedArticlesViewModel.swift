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

    func saveArticle(title: String, url: String, imageUrl: String?, content: String?) {
        let newSavedArticle = Article(context: PersistenceController.shared.container.viewContext)
        newSavedArticle.title = title
        newSavedArticle.imageURL = imageUrl
        newSavedArticle.content = content
        newSavedArticle.url = url
        newSavedArticle.dateSaved = Date()
        newSavedArticle.isRead = false // Por defecto, el artículo no se ha leído
        
        do {
            try PersistenceController.shared.container.viewContext.save()
            print("🤖: Article saved to read later")
            // Opcional: Actualizar la lista de artículos guardados
            fetchSavedArticles()
        } catch {
            print("🤖: Error saving article \(error.localizedDescription)")
        }
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
