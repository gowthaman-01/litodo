//
//  SettingsView.swift
//  Litodo
//
//  Created by gowthaman on 7/17/22.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    let themes: [Theme] = themeData
    
    // Access theme from local storage
    @ObservedObject var theme = ThemeSettings.shared
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // Themes
                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                        }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { theme in
                                Button(action: {
                                    self.theme.themeSettings = theme.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(theme.themeColor)
                                        Text(theme.themeName)
                                        Spacer()
                                        Text(themes[self.theme.themeSettings].themeColor == theme.themeColor ? "Selected" : "")
                                            .foregroundColor(Color.secondary)
                                    }
                                }
                                .accentColor(Color.primary)
                            }
                        }
                    }
                    // Links
                    Section(header: Text("Links")) {
                        LinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://gowthaman.app")
                        LinkView(icon: "envelope", color: Color.orange ,text: "Email", link: "mailto:gowthaman.aravindan@gmail.com")
                        LinkView(icon: "person.fill.viewfinder", color: Color.blue, text: "LinkedIn", link: "https://linkedin.com/gowthaman-aravindan")
                        LinkView(icon: "g.circle", color: Color.black, text: "Github", link: "https://github.com/gowthaman-01")
                    }
                    // About
                    Section(header: Text("About the app")) {
                        AboutView(icon: "gear", firstText: "Application", secondText: "Todo")
                        AboutView(icon: "checkmark.seal", firstText: "Compatiblity", secondText: "iPhone, iPad")
                        AboutView(icon: "keyboard", firstText: "Developer", secondText: "Gowthaman")
                        AboutView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }
                }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                    .padding(.vertical, -15)
                
                Text("Copyright © gowthaman.app")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .foregroundColor(Color.secondary)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
