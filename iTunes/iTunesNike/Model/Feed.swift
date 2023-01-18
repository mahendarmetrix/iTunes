//
//  Feed.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit

class Feed {
    var artistName : String?
    var id : String?
    var releaseDate : String?
    var name : String?
    var kind : String?
    var copyright : String?
    var artistId : String?
    var contentAdvisoryRating : String?
    var artistUrl : String?
    var artworkUrl100 : String?
    var url : String?
    var genres : String = ""
    
    init(dictionary : [String : Any]) {
        self.artistName = dictionary["artistName"] as? String
        self.id = dictionary["id"] as? String
        self.releaseDate = dictionary["releaseDate"] as? String
        self.name = dictionary["name"] as? String
        self.kind = dictionary["kind"] as? String
        self.copyright = dictionary["copyright"] as? String
        self.artistId = dictionary["artistId"] as? String
        self.contentAdvisoryRating = dictionary["contentAdvisoryRating"] as? String
        self.artistUrl = dictionary["artistUrl"] as? String
        self.artworkUrl100 = dictionary["artworkUrl100"] as? String
        self.url = dictionary["url"] as? String
        if let genres = dictionary["genres"] as? [Any]
        {
            for genre in genres{
                if let genre = genre as? [String : Any], let name = genre["name"] as? String
                {
                    self.genres = "\(self.genres), \(name)"
                }
            }
        }
    }
    
}
