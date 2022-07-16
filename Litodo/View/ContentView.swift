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
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.todoName, ascending: true)])  var todoItems: FetchedResults<Item>
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            // Displaying todo items
            ZStack {
                List {
                    ForEach(self.todoItems, id: \.self) { todoItem in
                        HStack{
                            Text(todoItem.todoName ?? "Unknown")
                            Spacer()
                            Text(todoItem.todoPriority ?? "Unknown")
                        }
                    } .onDelete(perform: deleteTodoItem)
                }
                .navigationBarTitle("Todos", displayMode: .inline)
                // Add Todo button
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                        self.showAddToDo.toggle()
                        print(type(of: self.todoItems))
                    print("hello")
                }){
                    Image(systemName: "plus")
                }.sheet(isPresented: $showAddToDo) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                })
                if todoItems.count == 0 {
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    private func deleteTodoItem(at offsets: IndexSet) {
        for index in offsets {
            let deleteItem = todoItems[index]
            managedObjectContext.delete(deleteItem)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


