//
//  ContentView.swift
//  To.do
//
//  Created by gowthaman on 7/16/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showAddToDo: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            // Todo item list
            List(0 ..< 5) {todoItem in
                Text("Hello World")
            }
            .navigationBarTitle("Todos", displayMode: .inline)
            // Add Todo button
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddToDo.toggle()
            }){
                Image(systemName: "plus")
            }.sheet(isPresented: $showAddToDo) {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                
            })
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

