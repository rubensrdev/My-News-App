//
//  SavedArticlesView.swift
//  mynews
//
//  Created by Ruben on 9/7/24.
//

import SwiftUI

struct SavedArticlesView: View {
    
    @ObservedObject var viewModel = SavedArticlesViewModel()
    @State private var selectedArticle: Article?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedArticles, id: \.self) { savedArticle in
                    VStack(alignment: .leading) {
                        Text(savedArticle.title ?? "No title...")
                            .font(.headline)
                    }
                    .onTapGesture {
                        selectedArticle = savedArticle
                        showingDetail = true
                    }
                }
                .onDelete(perform: viewModel.deleteSavedArticle)
            }
            .navigationTitle("News to read later")
        }
        .onAppear {
            viewModel.fetchSavedArticles()
        }
        .sheet(isPresented: $showingDetail) {
            if let article = selectedArticle {
                ArticleDetailView(article: article)
            }
        }
    }
}

#Preview {
    SavedArticlesView()
}
