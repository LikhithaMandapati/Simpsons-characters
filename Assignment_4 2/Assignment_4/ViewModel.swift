//
//  ViewModel.swift
//  Assignment_4
//
//  Created by student on 1/24/24.
//

import Foundation
import UIKit.UIImage

public class ViewModel {
    struct Figure: Codable {
        
        init() {
            firstURL = "url"
            icon = Icon(height: "h", url: "url", width: "w")
            result = "result"
            text = "text"
            imgUrl = "img"
        }
        
        let firstURL: String
        let icon: Icon
        let result: String
        let text: String
        let imgUrl : String
        
        var name: String {
            return text.components(separatedBy: "-").first ?? ""
        }
    }
        
        struct Icon: Codable {
            let height: String
            let url: String
            let width: String
        }
    
    var characters = [Figure]()
    
    func fetchData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion()
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let relatedTopics = json["RelatedTopics"] as? [[String: Any]] else {
                print("Invalid JSON format")
                completion()
                return
            }
            
            for case let relatedTopic in relatedTopics {
                if let figure = Figure(json: relatedTopic) {
                    self.characters.append(figure)
                }
            }
            completion()
        }
        task.resume()
    }
}

extension ViewModel.Figure {
    init?(json: [String: Any]) {
        guard let firstURL = json["FirstURL"] as? String,
              let iconJson = json["Icon"] as? [String: String],
              let text = json["Text"] as? String,
              let result = json["Result"] as? String
        else {
            return nil
        }
        
        self.result = result
        self.text = text
        
        if let height = iconJson["Height"],
           let url = iconJson["URL"],
           let width = iconJson["Width"] {
            self.icon = ViewModel.Icon(height: height, url: url, width: width)
            self.imgUrl = url
        } else {
            self.icon = ViewModel.Icon(height: "", url: "", width: "")
            self.imgUrl = ""
        }
        
        self.firstURL = firstURL
        
        var name: String {
            return text.components(separatedBy: "-").first ?? ""
        }
    }
}
