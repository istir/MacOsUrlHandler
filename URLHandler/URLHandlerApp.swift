//
//  URLHandlerApp.swift
//  URLHandler
//
//  Created by Joachim Bargsten on 04/01/2023.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  func application(_: NSApplication, open urls: [URL]) {
      guard let appName = extractAppName(from: convertURLArrayToString(urls: urls)) else {return}
      guard let appConfig = try? loadConfig(path: getConfigFilePath(),key: appName) else { return }
      guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier:appConfig.appScheme)
    else { return }
      guard let newScheme = replaceHostInURL(originalURL: urls[0], newHost: appName) else {return}
      let schemeToPass = convertURLToString(url: newScheme)
      let configuration = NSWorkspace.OpenConfiguration()
      configuration.arguments = [schemeToPass]
      NSWorkspace.shared.openApplication(at: url, configuration: configuration, completionHandler: nil)

  }
}
