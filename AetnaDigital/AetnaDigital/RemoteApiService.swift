//
//  RemoteApiService.swift
//  AetnaDigital
//
//  Created by Mark Hoyt on 3/29/17.
//  Copyright © 2017 Mark Hoyt. All rights reserved.
//

import Foundation
import BoltsSwift
import Alamofire

open class RemoteAPIService {
    
    var apiURL: String = "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=1&tags="
    
    open func fetchImagesWithSearchTerm(_ searchTerm: String?) -> Task<AnyObject>! {
        let responseTask = TaskCompletionSource<AnyObject>()
        var editedApiString = apiURL
        if let _searchTerm = searchTerm {
            editedApiString.append(_searchTerm)
        }
        Alamofire.request(editedApiString, method: .get).responseJSON { (response) in
            if let _value = response.result.value as? NSDictionary, let _items = _value["items"] as? [NSDictionary] {
                var finalItems = [FlickrImage]()
                for i in 0 ..< _items.count {
                    let currentItem = FlickrImage(jsonData: _items[i])
                    finalItems.append(currentItem)
                }
                responseTask.set(result: finalItems as AnyObject)
            } else {
                var error: NSError!
                if let _error = response.error, let _response = response.response {
                    error = NSError(domain: "AetnaDigital", code: _response.statusCode, userInfo: ["userInfo" : _error])
                } else {
                    let statusCode = 500
                    error = NSError(domain: "AetnaDigital", code: statusCode, userInfo: nil)
                }
                responseTask.set(error: error)
            }
        }
        return responseTask.task
    }
    
    fileprivate func editAndReturnUrlForSearch() {
        
    }
}
