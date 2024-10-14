//
//  StoryViewController.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import UIKit

class StoryViewController: UIViewController {


    var storyImage: String? // The image to display

    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true // Enable interaction
        return imageView
    }()
    
    private let downloadButton: UIButton = {
           let button = UIButton(type: .system)
           let downloadImage = UIImage(systemName: "square.and.arrow.down") // Download icon
           button.setImage(downloadImage, for: .normal)
           button.tintColor = .white
           button.translatesAutoresizingMaskIntoConstraints = false
            button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
           return button
       }()

       private let heartButton: UIButton = {
           let button = UIButton(type: .system)
           let heartImage = UIImage(systemName: "heart") // Heart icon
           button.setImage(heartImage, for: .normal)
           button.tintColor = .white
           button.translatesAutoresizingMaskIntoConstraints = false
           button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
           return button
       }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.backward.circle.fill") // Heart icon
        button.setImage(backImage, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return button
    }()
    private var isHeartFilled = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupStoryImageView()
        setupButtons()
        // Add tap gesture recognizer to dismiss StoryViewController
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissStory))
        storyImageView.addGestureRecognizer(tapGesture)
    }

    // Set up the story image view
    private func setupStoryImageView() {
        view.addSubview(storyImageView)

        NSLayoutConstraint.activate([
            storyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            storyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            storyImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            storyImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])

        // Load the selected story image
        if let imageName = storyImage {
            storyImageView.image = UIImage(named: imageName)
        }
    }
    
    // Set up the buttons
     private func setupButtons() {
         // Add buttons to the view hierarchy
         view.addSubview(downloadButton)
         view.addSubview(heartButton)
         view.addSubview(backButton)
         NSLayoutConstraint.activate([
             downloadButton.topAnchor.constraint(equalTo: storyImageView.topAnchor, constant: 4),
             downloadButton.trailingAnchor.constraint(equalTo: storyImageView.trailingAnchor, constant: 0),
             downloadButton.widthAnchor.constraint(equalToConstant: 50),
             downloadButton.heightAnchor.constraint(equalToConstant: 50)
         ])

         // Constraints for the heart button (Bottom-right corner with 8-point padding)
         NSLayoutConstraint.activate([
             heartButton.bottomAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: -4),
             heartButton.trailingAnchor.constraint(equalTo: storyImageView.trailingAnchor, constant: 0),
             heartButton.widthAnchor.constraint(equalToConstant: 50),
             heartButton.heightAnchor.constraint(equalToConstant: 50)
         ])
         //
         NSLayoutConstraint.activate([
             backButton.topAnchor.constraint(equalTo: storyImageView.topAnchor, constant: 4),
             backButton.leadingAnchor.constraint(equalTo: storyImageView.leadingAnchor, constant: 0),
             backButton.widthAnchor.constraint(equalToConstant: 50),
             backButton.heightAnchor.constraint(equalToConstant: 50)
         ])

         // Add actions to the buttons if needed
         downloadButton.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
         heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
         backButton.addTarget(self, action: #selector(dismissStory), for: .touchUpInside)

     }

        // Action for the download button
        @objc private func downloadImage() {
            print("download button tapped!")
        }
    // Action for heart button
    @objc private func heartButtonTapped() {
        print("Heart button tapped!")
        isHeartFilled.toggle()
           
        let heartImageName = isHeartFilled ? "heart.fill" : "heart" // Choose appropriate icon
        let heartImage = UIImage(systemName: heartImageName)
        heartButton.setImage(heartImage, for: .normal)
    }


    // Dismiss StoryViewController when tapped
      @objc func dismissStory() {
          dismiss(animated: true, completion: nil)
      }
}

