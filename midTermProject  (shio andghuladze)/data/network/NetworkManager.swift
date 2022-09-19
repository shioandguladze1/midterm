//
//  NetworkManager.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import Foundation
import UIKit

class NetworkManger{
    private static let config = URLSessionConfiguration.default
    private static let session = URLSession(configuration: config)
    
    static func generateResult<T>(data: T?, error: Error?, onResult: (Result)-> Void){
        
        if let e = error {
            let result = ErrorResult(errorMessage: e.localizedDescription)
            onResult(result)
            return
        }
        
        if let d = data {
            let result = SuccessResult(data: d)
            onResult(result)
            return
        }
        
        let result = ErrorResult(errorMessage: "Unknown error")
        onResult(result)
        
    }

    static func parseResult<T>(result: Result, onSuccess: (T)-> Void, onError: (String)-> Void = { print($0) }){
        
        if let successResult = result as? SuccessResult<T> {
            onSuccess(successResult.data)
        }
        
        if let errorResult = result as? ErrorResult {
            onError(errorResult.errorMessage)
        }
        
    }

    static func getImage(imageUrl: String, imageView: UIImageView, placeHolder: UIImage?, onSuccess: @escaping ()-> Void, onError: @escaping (String)-> Void = { print($0) }){
        
        guard let url = URL(string: imageUrl) else {
            onError("invalid url \(imageUrl)")
            return
        }
        
        imageView.sd_setImage(with: url, placeholderImage: placeHolder) { image, error, cacheType, url in
            guard let error = error else {
                onSuccess()
                return
            }
            
            onError(error.localizedDescription)
        }
        
    }

}
