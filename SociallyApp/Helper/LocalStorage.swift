//
//  LocalStorage.swift
//  SociallyApp
//
//  Created by macbook 2018 on 14/10/2024.
//

import Foundation
import UIKit

func savePosts(_ posts: [Post], key: String) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601 // Optional: For consistent date formatting

    if let encoded = try? encoder.encode(posts) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}

func saveStories(_ stories: [Story], key: String) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(stories) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}
func loadPosts(key: String) -> [Post]? {
    if let savedPosts = UserDefaults.standard.data(forKey: key) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Optional: For consistent date formatting
        return try? decoder.decode([Post].self, from: savedPosts)
    }
    return nil
}

func loadStories(key: String) -> [Story]? {
    if let savedStories = UserDefaults.standard.data(forKey: key) {
        let decoder = JSONDecoder()
        return try? decoder.decode([Story].self, from: savedStories)
    }
    return nil
}

// Helper function to get the local documents directory
func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

// Save image data to local storage
func saveImageToLocal(imageData: Data, withName name: String) -> URL {
    let fileURL = getDocumentsDirectory().appendingPathComponent(name)
    try? imageData.write(to: fileURL, options: .atomic)
    return fileURL
}

func saveImage(_ image: UIImage, withName name: String) -> String? {
    if let imageData = image.jpegData(compressionQuality: 1.0) {
        let savedURL = saveImageToLocal(imageData: imageData, withName: name)
        return savedURL.lastPathComponent // Store only the file name
    }
    return nil
}

func loadImage(named name: String) -> UIImage? {
    let fileURL = getDocumentsDirectory().appendingPathComponent(name)
    if FileManager.default.fileExists(atPath: fileURL.path) {
        return UIImage(contentsOfFile: fileURL.path)
    }
    return nil
}


func deleteFileFromLocal(withName name: String) {
    let fileManager = FileManager.default
    let fileURL = getDocumentsDirectory().appendingPathComponent(name)
    
    do {
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
            print("Image deleted successfully.")
        } else {
            print("File does not exist.")
        }
    } catch {
        print("Could not delete file: \(error.localizedDescription)")
    }
}

func deletePostImage(named name: String) {
    deleteFileFromLocal(withName: name)
}

