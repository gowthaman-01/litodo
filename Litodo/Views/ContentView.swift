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
    @State private var showSettings: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.todoName, ascending: true)])  var todoItems: FetchedResults<Item>
    // Access theme from local storage
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData

    // MARK: - BODY
    var body: some View {
        NavigationView {
            // Displaying todo items
            ZStack {
                List {
                    ForEach(self.todoItems, id: \.self) { todoItem in
                        HStack{
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: todoItem.todoPriority ?? "Normal"))
                            Text(todoItem.todoName ?? "")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(todoItem.todoPriority ?? "")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75))
                        }
                        .padding(.vertical, 5)
                    } .onDelete(perform: deleteTodoItem)
                }
                .navigationBarTitle("Todos", displayMode: .inline)
                // Settings Button
                .navigationBarItems(
                    leading: EditButton().foregroundColor(themes[self.theme.themeSettings].themeColor),
                    trailing:
                    Button(action: {
                        self.showSettings.toggle()
                }){
                    Image(systemName: "gear")
                        .foregroundColor(themes[self.theme.themeSettings].themeColor)
                })
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }

                if todoItems.count == 0 {
                    EmptyView()
                }
            }
            .sheet(isPresented: $showAddToDo) {
              AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(0.2)
                            .frame(width: 68, height: 68, alignment: .center)
                    }
                    Button(action: {
                        self.showAddToDo.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
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
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


