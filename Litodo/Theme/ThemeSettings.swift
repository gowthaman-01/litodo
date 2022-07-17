//
//  ThemeSettings.swift
//  Litodo
//
//  Created by gowthaman on 7/17/22.
//

import Foundation
import SwiftUI

final public class ThemeSettings: ObservableObject {
  @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
    didSet {
      UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
    }
  }
  
  public init() {}
  public static let shared = ThemeSettings()
}
