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
    
    private var isRequestInProgress = false
    
    func makeRequest(with url : URL, params : [String : String] = [String : String](), method : RequestType = .GET, onCompletion : CompletionHandlerWithModal<Result<Data>> = nil){
        
        if !isRequestInProgress{
            isRequestInProgress = true
            
            var request = URLRequest(url: url)
            let session = URLSession.shared
            request.httpMethod = method.rawValue
        
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                print("Response: \(String(describing: response))")
                
                if let err = error{
                    onCompletion?(.failure(err))
                }
                
                guard let data = data else{
                    onCompletion?(.failure(nil))
                    return
                }
                
                onCompletion?(.success(data))
            })
            task.resume()
        }
        else{
            onCompletion?(.failure(nil))
        }
    }
    
    func makeRequest<T : Codable>(with url : URL, params : [String : String] = [String : String](), method : RequestType = .GET, onCompletion : CompletionHandlerWithModal<Result<T>> = nil){
        
            self.makeRequest(with: url, params: params, method: method) { (resultData : Result<Data>) in
                switch resultData{
                case .success(let data):
                    do{
                        let aDecoder = JSONDecoder()
                        
                        let decodedModel = try aDecoder.decode(T.self, from: data)
                        onCompletion?(.success(decodedModel))
                    }
                    catch let e{
                        print("Error : \(e)")
                        onCompletion?(.failure(e))
                    }
                    break
                case.failure(let err) :
                    onCompletion?(.failure(err))
                }
            }
    }
}
