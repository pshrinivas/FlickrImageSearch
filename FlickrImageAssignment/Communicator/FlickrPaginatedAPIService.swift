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
    let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text="
 
    func fetch(searchKeyWord : String, onCompletion : CompletionHandlerWithModal<Result<[AlbumModel]>> = nil){
        
        let generatedUrlString = urlString + searchKeyWord + "&page=\(page)"
        if let url = URL(string: generatedUrlString){
            communicator.makeRequest(with: url) {[weak self] (result : Result<FlickrParentResponse>) in
                
                guard let strongSelf = self else{
                    return
                }
                
                switch(result){
                case .success(let model):
                    strongSelf.page = strongSelf.page + 1;
                    onCompletion?(.success(model.photos.photo.compactMap({$0})))
                    break
                case .failure(let err):
                    onCompletion?(.failure(err))
                    break
                }
            }
        }
        else{
            onCompletion?(.failure(nil))
        }
        
        
        
        
    }
    
}
