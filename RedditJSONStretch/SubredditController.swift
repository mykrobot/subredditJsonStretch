//
//  SubredditController.swift
//  RedditJSONStretch
//
//  Created by Michael Mecham on 3/28/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class SubredditController: NSObject {
    
    static let kBaseURL = "https://www.reddit.com/r/"
    // https://www.reddit.com/r/\(insertSubredditHere).json
    
    static func getSubreddit(searchTerm: String, completion: (subreddit: Subreddit?) -> Void) {
        let subSearchURL = kBaseURL + searchTerm.lowercaseString + ".json"
        let url = NSURL(string: subSearchURL)
        NetworkController.dataAtURL(url!) { (data) -> Void in
            guard let data = data else {
                print("\(__FILE__) on line \(__LINE__) returned no data")
                completion(subreddit: nil)
                return
            }
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let dictionary = jsonObject as? [String:AnyObject] {
                    let subreddit = Subreddit(jsonDictionary: dictionary)
                    completion(subreddit: subreddit)
                } else {
                    completion(subreddit: nil)
                }
            } catch {
                print("\(__FILE__) on line: \(__LINE__) : Threw some errors")
                completion(subreddit: nil)
            }
        }
    }
}
