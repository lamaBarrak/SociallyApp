//
//  Post.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import Foundation

class Post: Codable {
     var id: String
    var publisherImage: String
    var publisherName: String
    var postDate: String
    var postImage: String?
    var postText: String
    var interactions: Int
    var comments: [String]
    var isLiked: Bool

    // Initializer to setup the properties
    init(id:String,
         publisherImage: String,
         publisherName: String,
         postDate: String,
         postImage: String? = nil,
         postText: String,
         interactions: Int,
         comments: [String], isLiked: Bool = false ) {
        self.id = id
        self.publisherImage = publisherImage
        self.publisherName = publisherName
        self.postDate = postDate
        self.postImage = postImage
        self.postText = postText
        self.interactions = interactions
        self.comments = comments
        self.isLiked = isLiked
    }
  
}

