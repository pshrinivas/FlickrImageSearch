//
//  AlbumCellViewModel.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

struct AlbumCellViewModel{
    
    var url : URL?
    var title : String
    
    init(albumModel : AlbumModel) {
        url = albumModel.imageURL
        title = albumModel.title
    }
}
