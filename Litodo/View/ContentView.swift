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
    @State private var animatingButton: Bool = false
    @State private var showSettings: Bool = false
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
                        self.showSettings.toggle()
                }){
                    Image(systemName: "gear")
                })
                if todoItems.count == 0 {
                    EmptyView()
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                    }
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: animatingButton)
                    .onAppear(perform: {self.animatingButton.toggle()})
                    Button(action: {
                        self.showAddToDo.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    
                }
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                    , alignment: .bottomTrailing
            )
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


