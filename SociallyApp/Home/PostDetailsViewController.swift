//
//  PostDetailsViewController.swift
//  SociallyApp
//
//  Created by macbook 2018 on 13/10/2024.
//

import UIKit


class PostDetailsViewController: UIViewController {

    var post: Post? // The post data to display
    
    @IBOutlet weak var publisherImageView: UIImageView!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var interactionCountLabel: UILabel!
    @IBOutlet weak var heartimgView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var addCommentTextField: UITextField!
    
    
    @IBOutlet weak var postImageViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        commentsTableView.dataSource = self
        // Register the table view cell class for reuse
           commentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommentsCell")
    }
    private func setupUI() {
           guard let post = post else { return }
           
           // Populate the post details
           publisherImageView.image = UIImage(named: post.publisherImage)
           publisherImageView.layer.cornerRadius = publisherImageView.frame.height / 2
           publisherImageView.clipsToBounds = true

           publisherNameLabel.text = post.publisherName
        postDateLabel.text = post.postDate
           postTextLabel.text = post.postText
           interactionCountLabel.text = "\(post.interactions)"
           commentCountLabel.text = "\(post.comments.count)"

           if let postImageName = post.postImage {
               postImageView.image = UIImage(named: postImageName)
               postImageView.isHidden = false
           } else {
               postImageView.isHidden = true
               postImageViewHeightConstraint.constant = 0
           }
        // Change the tint color to white 
            navigationController?.navigationBar.tintColor = .white
        // Set heart icon based on `isLiked`
       updateHeartImage(isLiked: post.isLiked)
        
    
        setupHeartImageViewGesture()
        // Add action for the text field to handle adding new comments
           addCommentTextField.addTarget(self, action: #selector(addComment), for: .editingDidEndOnExit)
       }
    
    // MARK: - Setup Heart Image View Gesture Recognizer
      private func setupHeartImageViewGesture() {
          heartimgView.isUserInteractionEnabled = true  // Enable user interaction
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleLikeStatus))
          heartimgView.addGestureRecognizer(tapGesture)
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
        interactionCountLabel.text = "\(post.interactions)"
        updateHeartImage(isLiked: post.isLiked)
    }
    
    // MARK: - Update Heart Image Based on Like Status
       private func updateHeartImage(isLiked: Bool) {
           let heartImageName = isLiked ? "heart.fill" : "heart"  // Use SF Symbols names
           heartimgView.image = UIImage(systemName: heartImageName)
       }
    @objc private func addComment() {
        guard let newComment = addCommentTextField.text, !newComment.isEmpty, let post = post else { return }
           post.comments.append(newComment)
           addCommentTextField.text = ""
           commentCountLabel.text = "\(post.comments.count)"
           commentsTableView.reloadData()
       }
   
    
   }

   // MARK: - UITableViewDataSource for Comments
   extension PostDetailsViewController: UITableViewDataSource ,UITableViewDelegate{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return post?.comments.count ?? 0
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath)
           cell.textLabel?.text = post?.comments[indexPath.row]
           return cell
       }
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return 25
       }
       // Enable swipe-to-delete
           func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
               if editingStyle == .delete {
                   post?.comments.remove(at: indexPath.row)
                   commentsTableView.deleteRows(at: [indexPath], with: .automatic)
                   commentCountLabel.text = "\(post?.comments.count ?? 0 )"
                   
               }
           }
   }
