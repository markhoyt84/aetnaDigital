//
//  FlickrImage.swift
//  AetnaDigital
//
//  Created by Mark Hoyt on 3/29/17.
//  Copyright © 2017 Mark Hoyt. All rights reserved.
//

import Foundation

open class FlickrImage : AnyObject {
    
    var title: String?
    var imageURL: String?
    var publishedDate: String?
    var author: String?
    var tags: [String]?

    public init(jsonData: NSDictionary) {
        self.title = jsonData["title"] as? String
        self.imageURL = getImageURLFromData(jsonData["media"] as? NSDictionary)
        self.publishedDate = jsonData["published"] as? String
        self.author = jsonData["author"] as? String
        self.tags = getImageTagsFromData(jsonData["tags"] as? String)
    }
    
    fileprivate func getImageURLFromData(_ media: NSDictionary?) -> String? {
        if let _media = media, let _url = _media["m"] as? String {
            return _url
        } else {
            return nil
        }
    }
    
    fileprivate func getImageTagsFromData(_ tags: String?) -> [String]? {
        var finalTags:[String] = []
        if let _tags = tags {
            finalTags = _tags.components(separatedBy: " ")
        }
        return finalTags
    }
}
