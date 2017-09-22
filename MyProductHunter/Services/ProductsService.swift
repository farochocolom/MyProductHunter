//
//  ProductsService.swift
//  MyProductHunter
//
//  Created by Fernando on 9/21/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

struct ProductService {
    static func getFeaturedProducts(completion: @escaping ([Post]?) -> Void) {
        let session = URLSession.shared
        let baseURL = URL(string: Constants.URLs.BASE_URL + Constants.URLs.MY_PROFILE + Constants.URLs.POSTS)!
        let dispatchGroup = DispatchGroup()
        var request = URLRequest(url: baseURL)
        request.setValue("Bearer 0179e0017d2d4d388e62be3a6ddb5f5604c1512e6c47448fbd8d58ce6b2a82e7", forHTTPHeaderField: "Authorization")
        
        dispatchGroup.enter()
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
//                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(json)
                
                let postList = try? JSONDecoder().decode(Post.self, from: data)
                
                guard let posts = postList?.posts else {return}
                
                dispatchGroup.leave()
                
                dispatchGroup.notify(queue: .main, execute: {
                    completion(posts)
                })
            }
            
            
        }.resume()
    }
    
    static func getPostImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        
        
        dispatchGroup.enter()
        session.dataTask(with: url) { (data, res, err) in
            
            if let error = err{
                print("Error getting picture: \(error)")
                dispatchGroup.leave()
            }
            
            guard let response = res as? HTTPURLResponse,
                let imageData = data else {
                    dispatchGroup.leave()
                    return
            }
            
            let image = UIImage(data: imageData)
            dispatchGroup.leave()
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(image)
            })
        }.resume()
        
        

        
    }
}
