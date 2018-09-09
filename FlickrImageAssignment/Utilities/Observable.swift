//
//  Observable.swift
//  FlickrImageAssignment
//
//  Created by Shrinivas Prabhu on 09/09/18.
//  Copyright © 2018 Shrinivas Prabhu. All rights reserved.
//

import Foundation

class Observer<T> {
    typealias Listener = (T) -> Void
    private var observer : Listener?
    
    func bind(_ listener: Listener?) {
        observer = listener
    }
    
    func unbind(){
        observer = nil
    }
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
