//
//  AddTodoView.swift
//  To.do
//
//  Created by gowthaman on 7/16/22.
//

import SwiftUI

struct AddTodoView: View {
// MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var todoName: String = ""
    @State private var todoPriority: String = "Normal"
    let todoPriorities: Array = ["High", "Normal", "Low"]
    
// MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // Input field
                    TextField("Todo", text: $todoName)
                    // Priority selector
                    Picker("Priority", selection: $todoPriority) {
                        ForEach(todoPriorities, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    // Save Button
                    Button(action: {
                        if self.todoName != "" {
                            let todoItem = Item(context: self.managedObjectContext)
                            todoItem.todoName = self.todoName
                            todoItem.todoPriority = self.todoPriority
                            do {
                                try self.managedObjectContext.save()
                                print("New todo: \(todoItem.todoName ?? ""), Priority \(todoItem.todoPriority ?? "")")
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        Text("Save")
                    }
                }
                Spacer()
            }
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
        }
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
