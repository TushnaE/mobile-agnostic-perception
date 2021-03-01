//
//  mapApp.swift
//  Shared
//
//  Created by Davon Prewitt on 2/28/21.
//

import SwiftUI

@main
struct mapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
