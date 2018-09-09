//
//  FlickrResponse.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//



/*{
    "photos": {
        "page": 3000,
        "pages": 4939,
        "perpage": 100,
        "total": "493847",
        "photo": [
        {
        "id": "29627245727",
        "owner": "83916432@N07",
        "secret": "9d307d8d11",
        "server": "1867",
        "farm": 2,
        "title": "IMG_7196",
        "ispublic": 1,
        "isfriend": 0,
        "isfamily": 0
        },
        {
        "id": "30694959538",
        "owner": "83916432@N07",
        "secret": "5f5990942f",
        "server": "1883",
        "farm": 2,
        "title": "IMG_7189",
        "ispublic": 1,
        "isfriend": 0,
        "isfamily": 0
        },
         .
         .
         .
         .
         .
        ]
 
 "stat": "ok"
 }
 
 */
        
import Foundation

struct FlickrResponse : Codable{
    var page : Int
    var pages : Int?
    var perpage : Int
    var photo : [AlbumModel?]
    
}

struct FlickrParentResponse: Codable{
    var photos : FlickrResponse
}

