//
//  LitodoApp.swift
//  Litodo
//
//  Created by gowthaman on 7/16/22.
//

import SwiftUI

@main
struct LitodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
