//
//  PostCollectionViewCell.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func didTapComment(for post: Post)
    
}

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var publisherImageView: UIImageView!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var interactionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var heartimgView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
   
   

    @IBOutlet weak var postImageViewHeightConstraint: NSLayoutConstraint!
    
    var post: Post?
    weak var delegate: PostCellDelegate?
    private var commentsVisible = false  // Track comment section visibility
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
       
    }

    private func setupViews() {
        // Make publisher image circular
        publisherImageView.layer.cornerRadius = publisherImageView.frame.height / 2
        publisherImageView.clipsToBounds = true
        
        // Configure the post text label
        postTextLabel.numberOfLines = 0  // Allow multiple lines
        postTextLabel.lineBreakMode = .byWordWrapping  // Wrap text properly
        postTextLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)  // Ensure label height adjusts to content

        

        // Add tap gesture for the comment image view to toggle comments visibility
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(commentTapped))
        commentImageView.isUserInteractionEnabled = true
        commentImageView.addGestureRecognizer(tapGesture)
        setupHeartImageViewGesture()
        
  
    }
    
    // MARK: - Setup Heart Image View Gesture Recognizer
      private func setupHeartImageViewGesture() {
          heartimgView.isUserInteractionEnabled = true  // Enable user interaction
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleLikeStatus))
          heartimgView.addGestureRecognizer(tapGesture)
      }
  
    // MARK: - Configure Cell with Post Data
       func configureCell(with post: Post) {
           self.post = post
           // Set publisher's image, name, and post date
           publisherImageView.image = UIImage(named: post.publisherImage)
           publisherNameLabel.text = post.publisherName
           postDateLabel.text = post.postDate

           // Set post image (if it exists)
           // Configure post image visibility
            if let postImage = post.postImage , let image =  UIImage(named: postImage) {
                     
            let im = image.resizeTo(height: 128,width: 128)
                      postImageView.image = im
                      postImageView.isHidden = false
                      postImageViewHeightConstraint.constant = 200 // Set appropriate height
            } else {
                      postImageView.isHidden = true
                      postImageViewHeightConstraint.constant = 0 // Collapse the height
                
            }

           // Set post text, interactions, and comments
           postTextLabel.text = post.postText
           interactionLabel.text = "\(post.interactions)"
           commentLabel.text = "\(post.comments.count)"
           
           postTextLabel.sizeToFit()  // Ensure the label resizes to fit the content
         
           // Set heart icon based on `isLiked`
          updateHeartImage(isLiked: post.isLiked)
           
           layoutIfNeeded()  // Force layout update after setting the content
           
       }
    // MARK: - Update Heart Image Based on Like Status
       private func updateHeartImage(isLiked: Bool) {
           let heartImageName = isLiked ? "heart.fill" : "heart"  // Use SF Symbols names
           heartimgView.image = UIImage(systemName: heartImageName)
       }

       // MARK: - Toggle Like Status
       @objc private func toggleLikeStatus() {
           guard let post = post else { return }

           post.isLiked.toggle()  // Toggle the like status

           if post.isLiked {
               post.interactions += 1  // Increase interaction count
           } else {
               post.interactions -= 1  // Decrease interaction count
           }

           // Update the UI
           interactionLabel.text = "\(post.interactions)"
           updateHeartImage(isLiked: post.isLiked)
       }
    @objc private func commentTapped() {
          guard let post = post else { return }
          delegate?.didTapComment(for: post)
      }


      
    }

// MARK: - UITableViewDataSource
extension PostCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        cell.textLabel?.text = post?.comments[indexPath.row]
        return cell
    }
}
