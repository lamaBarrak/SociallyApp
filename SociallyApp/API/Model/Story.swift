//
//  Story.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import Foundation


class Story: Codable {
    var id:String
    var publisherImage: String // Image name or URL string for the publisher
    var storyImage: String // Image name or URL string for the story
    
    init(id:String,publisherImage: String, storyImage: String) {
        self.id = id
        self.publisherImage = publisherImage
        self.storyImage = storyImage
    }
}
