//
//  mynewsApp.swift
//  mynews
//
//  Created by Ruben on 8/7/24.
//

import SwiftUI

@main
struct mynewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
