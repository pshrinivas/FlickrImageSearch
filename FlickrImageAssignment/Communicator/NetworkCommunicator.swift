//
//  NetworkCommunicator.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

public typealias CompletionHandlerWithModal<T> = ((T)->Void)?

class NetworkCommunicator {
    
    func makeRequest(with url : URL, params : [String : String] = [String : String](), method : RequestType = .GET, onCompletion : CompletionHandlerWithModal<Result<Data>> = nil){
    }
}
