//
//  FlickrServiceProtocol.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 11/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

protocol FlickrServiceProtocol : NSCopying {
    func fetch(searchKeyWord : String, onCompletion : CompletionHandlerWithModal<Result<[AlbumModel]>>)
}
