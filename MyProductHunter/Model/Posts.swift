//
//  Posts.swift
//  MyProductHunter
//
//  Created by Fernando on 9/21/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

struct Post: Decodable {
    var name: String!
    var tagline: String!
    var commentCount: Int!
    var thumbnailUrl: URL!
    var posts = [Post]()

    
    init(name: String, tagline: String, commentCount: Int , thumbnailUrl: URL) {
        self.name = name
        self.tagline = tagline
        self.commentCount = commentCount
        self.thumbnailUrl = thumbnailUrl
    }
}
