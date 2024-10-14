//
//  StoryCollectionViewCell.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    private let publisherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPublisherImageView()
    }

    private func setupPublisherImageView() {
        contentView.addSubview(publisherImageView)

        // Constraints for  image 
        NSLayoutConstraint.activate([
            publisherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            publisherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            publisherImageView.widthAnchor.constraint(equalToConstant: 68),  // Adjust size
            publisherImageView.heightAnchor.constraint(equalToConstant: 68)  // Adjust size
        ])

        // Make the image circular
        publisherImageView.layer.cornerRadius = 34
        publisherImageView.layer.borderWidth = 2
        publisherImageView.layer.borderColor = UIColor.white.cgColor
    }

    func configureCell(with story: Story) {
        if let image = UIImage(named: story.publisherImage) {
            publisherImageView.image = image
        }
    }
}
