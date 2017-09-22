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
    
    enum CommentsResultKeys: String, CodingKey {
        case comments
        
        enum CommentKeys: String, CodingKey {
            case body
            case user
        
            enum UserWhoCommentedKeys: String, CodingKey {
                case name
                case username
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        var commentsArrayContainer = try decoder.container(keyedBy: CommentsResultKeys.self)
        
        var commentArray = try commentsArrayContainer.nestedUnkeyedContainer(forKey: .comments)
    
        while !commentArray.isAtEnd {
            
            let commentContainer = try commentArray.nestedContainer(keyedBy: CommentsResultKeys.CommentKeys.self)
            
            let commentBody = try commentContainer.decode(String.self, forKey: .body)
        
            
            let userContainer = try commentContainer.nestedContainer(keyedBy: CommentsResultKeys.CommentKeys.UserWhoCommentedKeys.self, forKey: .user)
            
            let name = try userContainer.decode(String.self, forKey: .name)
            let username = try userContainer.decode(String.self, forKey: .username)
            
            
            let comment = Comment(body: commentBody, postedByName: name, postedByUsername: username)
            
            self.comments.append(comment)
        }
    }
}
