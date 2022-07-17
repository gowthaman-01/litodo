//
//  SettingsView.swift
//  Litodo
//
//  Created by gowthaman on 7/17/22.
//

import SwiftUI

struct AboutView: View {
    // MARK: - PROPERTIES
    var icon: String
    var firstText: String
    var secondText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.trailing, 4)
            Text(firstText)
                .foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

// MARK: - PREVIEW
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(icon: "gear", firstText: "Application", secondText: "Todo")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
