//
//  SettingsView.swift
//  Litodo
//
//  Created by gowthaman on 7/17/22.
//

import SwiftUI

struct LinkView: View {
    // MARK: - PROPERTIES
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.trailing, 4)
            Text(text)
                .foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
                
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }
    }
}

// MARK: - PREVIEW
struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://www.google.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}

