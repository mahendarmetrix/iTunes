//
//  ITunesSearchService.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit

class ITunesSearchService {
    
    typealias FeedResult = ([Feed]?, String) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var feeds: [Feed] = []
    var errorMessage = ""
    
    func getSearchResults(_ completion: @escaping FeedResult) {
        
        dataTask?.cancel()
        
        let urlStr = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
        
        guard let url = URL(string: urlStr) else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.parseFeeds(data)
                
                DispatchQueue.main.async {
                    completion(self.feeds, self.errorMessage)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    
    fileprivate func parseFeeds(_ data: Data) {
        var response: [String: Any]?
        feeds.removeAll()
        print(String.init(data: data, encoding: .utf8))
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let feedsDict = response!["feed"] as? [String: Any], let results = feedsDict["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        for resultsDictionary in results {
            if let resultsDictionary = resultsDictionary as? [String : Any]{
                feeds.append(Feed(dictionary: resultsDictionary))
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}
