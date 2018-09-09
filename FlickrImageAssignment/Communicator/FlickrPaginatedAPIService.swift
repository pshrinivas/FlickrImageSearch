//
//  FlickrPaginatedAPIService.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

class FlickrPaginatedAPIService{
    
    // first Page of any request
    var page = 1
    let communicator = NetworkCommunicator()
    let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736& format=json&nojsoncallback=1&safe_search=1&text=kittens&page="
    
    func fetch(onCompletion : CompletionHandlerWithModal<Result<FlickrResponse>> = nil){
        
        if let url = URL(string: urlString + String(page)){
            communicator.makeRequest(with: url) {[weak self] (result : Result<FlickrResponse>) in
                
                guard let strongSelf = self else{
                    return
                }
                
                switch(result){
                case .success(let model):
                    strongSelf.page = strongSelf.page + 1;
                    onCompletion?(.success(model))
                    break
                case .failure(let err):
                    onCompletion?(.failure(err))
                    break
                }
            }
        }
        
        
        
        
    }
    
}
