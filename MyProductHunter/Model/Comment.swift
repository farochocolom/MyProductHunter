//
//  Comment.swift
//  MyProductHunter
//
//  Created by Fernando on 9/21/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

struct Comment: Decodable {
    var body: String!
    var postedByName: String!
    var postedByUsername: String!
    var comments = [Comment]()
    
    
    init(body: String, postedByName: String, postedByUsername: String) {
        self.body = body
        self.postedByName = postedByName
        self.postedByUsername = postedByUsername
    }
    
    // Main container - "search_results: []"
    enum CommentsResultKeys: String, CodingKey {
        case comments
        
        // Second container - { listing: listing_properties,
        //                      pricing_quote: values}
        enum CommentKeys: String, CodingKey {
            case body
            case user
            
            // Inside the listing container - "listing" : values
            enum UserWhoCommentedKeys: String, CodingKey {
                case name
                case username
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Go into main container
        var commentsArrayContainer = try decoder.container(keyedBy: CommentsResultKeys.self)
        
        // Get the array of unkeyed listings container
        var commentArray = try commentsArrayContainer.nestedUnkeyedContainer(forKey: .comments)
        
        
        // loop through every listing element
        while !commentArray.isAtEnd {
            
            let commentContainer = try commentArray.nestedContainer(keyedBy: CommentsResultKeys.CommentKeys.self)
            
            let commentBody = try commentContainer.decode(String.self, forKey: .body)
        
            
            let userContainer = try commentContainer.nestedContainer(keyedBy: CommentsResultKeys.CommentKeys.UserWhoCommentedKeys.self, forKey: .user)
            
            let name = try userContainer.decode(String.self, forKey: .name)
            let username = try userContainer.decode(String.self, forKey: .username)
            
            
            let comment = Comment(body: commentBody, postedByName: name, postedByUsername: username)
            
            // add the listing object to the structs listings arrays
            self.comments.append(comment)
        }
    }
}
