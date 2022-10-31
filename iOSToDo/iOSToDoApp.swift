//
//  iOSToDoApp.swift
//  iOSToDo
//
//  Created by Thassio Costa on 31/10/22.
//

import SwiftUI

@main
struct iOSToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
