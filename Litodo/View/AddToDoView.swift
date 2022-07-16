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
    // For error messages
    @State private var showError: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    
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
                            } catch {
                                print(error)
                            }
                        } else {
                            self.showError = true
                            self.errorTitle = "Invalid Input"
                            self.errorMessage = "Please enter your Todo item!"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
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
            }).alert(isPresented: $showError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
