//
//  util.swift
//  URLHandler
//
//  Created by Joachim Bargsten on 04/01/2023.
//

import Foundation

struct Config: Codable {
  var appScheme: String
}


func loadConfig(path: URL, key: String) -> Config? {
    do {
        // Read the contents of the file at the given URL
        let data = try Data(contentsOf: path)
        
        // Decode the JSON data into Config struct
        let decoder = JSONDecoder()
        let jsonObject = try decoder.decode([String: Config].self, from: data)
        
        // Find the Config associated with the specified key
        if let config = jsonObject[key] {
            return config // Return the Config for the specified key
        } else {
            print("Key '\(key)' not found in the JSON file.")
            return nil
        }
    } catch {
        print("Error reading or parsing the file: \(error.localizedDescription)")
        return nil
    }
}


func extractAppName(from uri: String) -> String? {
    if let url = URL(string: uri), let host = url.host {
        return host // Return the app name
    }
    return nil // Return nil if the host (app name) is not found or if the URL is invalid
}



func replaceHostInURL(originalURL: URL, newHost: String) -> URL? {
    var components = URLComponents(url: originalURL, resolvingAgainstBaseURL: false)
    components?.scheme = newHost
    return components?.url
}

func convertURLToString(url: URL) -> String {
    let result = url.absoluteString
    return result
}
func convertURLArrayToString(urls: [URL]) -> String {
    let urlStringArray = urls.map { $0.absoluteString }
    let result = urlStringArray.joined(separator: "\n")
    return result
}


func getConfigFilePath() throws -> URL {
  let x = ProcessInfo.processInfo.environment["XDG_CONFIG_HOME"]
    .flatMap { URL(fileURLWithPath: $0) } ?? FileManager.default.homeDirectoryForCurrentUser
  return x.appending(components: ".config", "uri-schemes.json")
}
