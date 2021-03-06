//
//  SearchViewController.swift
//  RedditJSONStretch
//
//  Created by Michael Mecham on 3/28/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var subredditSearchBar: UISearchBar!
    
    var subsArray: [String] = []
    var urlArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search Bar Methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        subredditSearchBar.resignFirstResponder()
        
        guard let searchTerm = subredditSearchBar.text else { return }
        SubredditController.getSubreddit(searchTerm) { (subreddit) -> Void in
            guard let subredditResult = subreddit else { return }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.subsArray = subredditResult.subsArray
                self.urlArray = subredditResult.urlsArray
                self.myTableView.reloadData()
                self.subredditSearchBar.text = ""
            })
            
        }
        
    }
    
    // MARK: - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subsArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subRedCell", forIndexPath: indexPath)
        let title = subsArray[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = NSURL(string: urlArray[indexPath.row]) 
        let viewController = SFSafariViewController(URL: url!)
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
