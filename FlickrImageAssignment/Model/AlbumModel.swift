//
//  AlbumModel.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

/*
 "id": "29627245727",
 "owner": "83916432@N07",
 "secret": "9d307d8d11",
 "server": "1867",
 "farm": 2,
 "title": "IMG_7196",
 "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0
 */

struct AlbumModel : Codable{
    var id : String
    var owner : String
    var secret : String
    var server : String
    var farm : Int
    var title : String
    
    var imageURL : URL?{
        let urlString = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        return URL(string: urlString)
    }
}
