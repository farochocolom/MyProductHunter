//
//  UIImage+Request.swift
//  MyProductHunter
//
//  Created by Fernando on 9/22/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

let imageCache = NSCache<UIImage, URL>()

extension UIImageView {
    func getPostImage(url: URL) {
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        
        if let imageFromCache = try? imageCache.object(forKey: url) {
            self.image = imageFromCache
        }
        
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
            
            DispatchQueue.global(qos: .background).async {
                let imagetoCache = UIImage(data: imageData)
                
                try? imageCache.setObject(imagetoCache!, forKey: url)
            }
            }.resume()
        
    }
}
