//
//  GridViewModel.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

struct GridViewModel{
    
    var albumArray : Observer<[AlbumModel]>
    
    func add(from array : [AlbumModel]){
        albumArray.value.append(contentsOf: array)
    }
    
}
