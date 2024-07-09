//
//  ContentView.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            NewsListView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            SavedArticlesView()
                .tabItem {
                    Label("Read later", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    Home()
}
