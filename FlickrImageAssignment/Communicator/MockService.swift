//
//  MockService.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 11/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

class  MockSucessService: FlickrServiceProtocol {
    func copy(with zone: NSZone? = nil) -> Any {
        return MockSucessService()
    }
    
    func fetch(searchKeyWord: String, onCompletion: ((Result<[AlbumModel]>) -> Void)? = nil) {
        
         let album1  = AlbumModel(id: "B1", owner: "", secret: "C", server: "A", farm: 1, title: "title1")
         let album2  = AlbumModel(id: "B2", owner: "", secret: "C", server: "A", farm: 2, title: "title2")
         let album3  = AlbumModel(id: "B3", owner: "", secret: "C", server: "A", farm: 3, title: "title3")
        
        let albumArray = [album1,album2,album3]
        
        onCompletion?(.success(albumArray))
        
    }
    
    
}

class  MockFailureService: FlickrServiceProtocol {
    func copy(with zone: NSZone? = nil) -> Any {
        return MockFailureService()
    }
    
    func fetch(searchKeyWord: String, onCompletion: ((Result<[AlbumModel]>) -> Void)? = nil) {
        
        let error = NSError(domain: "com.shrinivas", code: 204, userInfo: nil)
        onCompletion?(.failure(error))
        
    }
    
    
}
