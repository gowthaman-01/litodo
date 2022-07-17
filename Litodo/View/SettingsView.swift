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
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text("Links")) {
                        LinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://gowthaman.app")
                        LinkView(icon: "envelope", color: Color.orange ,text: "Email", link: "mailto:gowthaman.aravindan@gmail.com")
                        LinkView(icon: "person.fill.viewfinder", color: Color.blue, text: "LinkedIn", link: "https://linkedin.com/gowthaman-aravindan")
                        LinkView(icon: "g.circle", color: Color.black, text: "Github", link: "https://github.com/gowthaman-01")
                    }
                    
                    Section(header: Text("About the app")) {
                        AboutView(icon: "gear", firstText: "Application", secondText: "Todo")
                        AboutView(icon: "checkmark.seal", firstText: "Compatiblity", secondText: "iPhone, iPad")
                        AboutView(icon: "keyboard", firstText: "Developer", secondText: "Gowthaman")
                        AboutView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
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
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
