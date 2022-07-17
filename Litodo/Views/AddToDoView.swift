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
    // Access theme from local storage
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
// MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack (alignment: .leading, spacing: 20) {
                    // Input field
                    TextField("Todo", text: $todoName)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    // Priority selector
                    Picker("Priority", selection: $todoPriority) {
                        ForEach(todoPriorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

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
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
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
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
