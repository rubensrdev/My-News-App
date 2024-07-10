//
//  ArticleDetailView.swift
//  mynews
//
//  Created by Ruben on 10/7/24.
//

import SwiftUI

struct ArticleDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    let article: Article
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageUrl = article.imageURL, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                Text(article.title ?? "No Title")
                    .font(.title)
                    .padding()

                Text(article.content ?? "No Content")
                    .padding()

                Spacer()
            }
            .navigationTitle("Article Detail")
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                    }
                }
            }
        }
        
    }
}

#Preview {
    ArticleDetailView(article: Article())
}
