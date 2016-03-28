//
//  Subreddit.swift
//  RedditJSONStretch
//
//  Created by Michael Mecham on 3/28/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Subreddit {
    
    var subsArray: [String]
    
    init?(jsonDictionary: [String: AnyObject]) {
        guard let data = jsonDictionary["data"] as? [String:AnyObject] else { return nil }
        guard let childrenArray = data["children"] as? [[String:AnyObject]] else { return nil }
        self.subsArray = []
        for dataDictionary in childrenArray {
            guard let almostThereDictionary = dataDictionary["data"] as? [String:AnyObject] else { return nil }
            guard let title = almostThereDictionary["title"] as? String else { return nil }
            self.subsArray.append(title)
        }
    }
}
