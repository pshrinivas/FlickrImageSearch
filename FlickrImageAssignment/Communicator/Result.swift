//
//  Result.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case failure(Error?)
}

