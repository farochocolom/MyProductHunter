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
    var image = UIImage()
    var posts = [Post]()

    
    init(name: String, tagline: String, commentCount: Int , thumbnailUrl: URL) {
        self.name = name
        self.tagline = tagline
        self.commentCount = commentCount
        self.thumbnailUrl = thumbnailUrl
    }
}

extension Post {
    
    enum PostsResultKeys: String, CodingKey {
        case posts
        
        enum PostKeys: String, CodingKey {
            case name
            case tagline
            case commentCount = "comments_count"
            case thumbnail
            
            enum ThumbnailKeys: String, CodingKey {
                case imageUrl = "image_url"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        var postsArrayContainer = try decoder.container(keyedBy: PostsResultKeys.self)
        
        var postsArray = try postsArrayContainer.nestedUnkeyedContainer(forKey: .posts)
        
        while !postsArray.isAtEnd {
            
            let postContainer = try postsArray.nestedContainer(keyedBy: PostsResultKeys.PostKeys.self)
            
            let postName = try postContainer.decode(String.self, forKey: .name)
            let postTagline = try postContainer.decode(String.self, forKey: .tagline)
            let commentCount = try postContainer.decode(Int.self, forKey: .commentCount)
            
            let thumbnailContainer = try postContainer.nestedContainer(keyedBy: PostsResultKeys.PostKeys.ThumbnailKeys.self, forKey: .thumbnail)
            
            let imageUrl = try thumbnailContainer.decode(URL.self, forKey: .imageUrl)
            
            let post = Post(name: postName, tagline: postTagline, commentCount: commentCount, thumbnailUrl: imageUrl)
            
            self.posts.append(post)
        }
    }
}
