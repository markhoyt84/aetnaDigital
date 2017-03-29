//
//  SearchResultsTableViewController.swift
//  AetnaDigital
//
//  Created by Mark Hoyt on 3/29/17.
//  Copyright © 2017 Mark Hoyt. All rights reserved.
//

import UIKit
import BoltsSwift

class SearchResultsTableViewController: UITableViewController {
    
    var currentSearchString: String? {
        didSet {
            self.performSearch()
        }
    }
    
    
    var currentSearchResults: [FlickrImage]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _results = self.currentSearchResults {
            return _results.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let _results = self.currentSearchResults {
            let cell = tableView.dequeueReusableCell(withIdentifier: "image-cell", for: indexPath) as! FlickrImageTableViewCell
            let currentImageForCell = _results[indexPath.row]
            cell.currentImage = currentImageForCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _results = self.currentSearchResults {
            return 200
        } else {
            return 50
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension SearchResultsTableViewController {
    
    // MARK: - HTTP Methods
    
    fileprivate func performSearch() {
        let remoteAPIService = RemoteAPIService()
        remoteAPIService.fetchImagesWithSearchTerm(self.currentSearchString).continueWith { (task: Task!) -> AnyObject! in
            if let _error = task.error {
                print("Sorry there was an error performing this search")
            } else {
                if let _results = task.result as? [FlickrImage] {
                    self.currentSearchResults = _results
                }
            }
            return nil
        }
    }
}
