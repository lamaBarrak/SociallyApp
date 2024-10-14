//
//  HomeVC.swift
//  SociallyApp
//
//  Created by macbook 2018 on 12/10/2024.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var postCollectionView: UICollectionView!
   
    
    var stories: [Story] = [
        Story(id: "s1", publisherImage: "friend1", storyImage: "story1"),
        Story(id: "s2", publisherImage: "friend2", storyImage: "story2"),
        Story(id: "s3", publisherImage: "friend3", storyImage: "story3"),
        Story(id: "s4", publisherImage: "friend4", storyImage: "story4"),
        Story(id: "s5", publisherImage: "friend5", storyImage: "story5"),
        Story(id: "s6", publisherImage: "friend6", storyImage: "story6"),
        Story(id: "s7", publisherImage: "friend4", storyImage: "story7"),
        Story(id: "s8", publisherImage: "friend5", storyImage: "story8")
      ]
    
    // Sample posts
    var posts: [Post] = [
        Post(id: "p1", publisherImage: "friend1", publisherName: "Bob", postDate: "1 hr ago", postImage: "post1", postText: "Grateful for all the little things in life. Every moment counts, and every person matters.Wishing you all a day full of joy and good vibes!", interactions: 15, comments: ["comment1","comment3","comment2","comment3 "],isLiked: true),
        Post(id: "p2", publisherImage: "friend2", publisherName: "Alice", postDate: "2 hrs ago", postImage: "story8", postText: "Nothing beats a good coffee and a great conversation. ☕✨", interactions: 20, comments: ["comment1","comment2","comment3"]),
        Post(id: "p3", publisherImage: "friend3", publisherName: "Charlie", postDate: "3 hrs ago", postImage: nil, postText: "What a great time!", interactions: 30, comments: []),
        Post(id: "p4", publisherImage: "friend5", publisherName: "Carla", postDate: "6 hrs ago", postImage: "story5", postText: "Quick reminder: You are capable of more than you know. Don’t let fear hold you back from chasing your dreams. The future is bright!", interactions: 30, comments: ["comment1"]),
        Post(id: "p5", publisherImage: "friend4", publisherName: "John", postDate: "7 hrs ago", postImage: nil, postText: "Thankful for family, friends, and all the little things. 🥰 It’s the simple moments that count the most. What are you grateful for today?", interactions: 30, comments: [],isLiked: true)
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Save posts and stories after fetching them from api
        savePosts(posts, key: "userPosts")
        saveStories(stories, key: "userStories")
        setupCollectionViews()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        postCollectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Set corner radius
        storyCollectionView.layer.cornerRadius = 40

        // Apply the mask to only left and right corners
        storyCollectionView.layer.maskedCorners = [.layerMinXMinYCorner,  // Top-left corner
                                                   .layerMinXMaxYCorner,  // Bottom-left corner
                                                   .layerMaxXMinYCorner,  // Top-right corner
                                                   .layerMaxXMaxYCorner]  // Bottom-right corner

        // Ensure subviews respect the corner mask
        storyCollectionView.layer.masksToBounds = true
    }
    
    func setupCollectionViews(){
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
    }

    func loadPostsFromLocalStorage(){

        if let posts = loadPosts(key: "userPosts") {
            for post in posts {
                if let publisherImage = loadImage(named: post.publisherImage) {
                    print("Loaded publisher image for post \(post.id)")
                }
                if let postImageName = post.postImage,
                   let postImage = loadImage(named: postImageName) {
                    print("Loaded post image for post \(post.id)")
                }
            }
        }
        //      Example of saving posts with images
        //        if let publisherImageName = saveImage(UIImage(named: "publisherImage")!, withName: "publisher1.jpg"),
        //           let postImageName = saveImage(UIImage(named: "postImage")!, withName: "post1.jpg") {
        //
        //            let post = Post(id: "1",
        //                            publisherImage: publisherImageName,
        //                            publisherName: postImageName,
        //                            postDate: "Nader Ahmad",
        //                            postImage: "2024-10-13",
        //                            postText: "Hello World!",
        //                            interactions: 5,
        //                            comments: ["Nice!", "Cool!"],
        //                            isLiked: true)
        //
        //            savePosts([post], key: "userPosts")
        //        }

    }

}


// MARK: - UICollectionView DataSource and Delegate
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storyCollectionView {
            return stories.count
        } else {
            return posts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {
                       return UICollectionViewCell()
                   }
                   let story = stories[indexPath.item]
                   cell.configureCell(with: story)
                   return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
            let post = posts[indexPath.row]
            
            // Configure the cell with the post data
            cell.configureCell(with: post)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == storyCollectionView {
            let selectedStory = stories[indexPath.row]
            openStoryView(with: selectedStory)}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Open the StoryViewController when a story is tapped
    func openStoryView(with story: Story) {
        let storyVC = StoryViewController()
        storyVC.storyImage = story.storyImage

        // Embed StoryViewController in a UINavigationController
        let navigationController = UINavigationController(rootViewController: storyVC)
        navigationController.modalPresentationStyle = .overFullScreen

        // Present the UINavigationController
        present(navigationController, animated: true, completion: nil)
    }
    
    private func navigateToPostDetails(for post: Post) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let postDetailsVC = storyboard.instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
           postDetailsVC.post = post
     
           navigationController?.pushViewController(postDetailsVC, animated: true)
       }
}
// MARK: - PostCellDelegate
extension HomeVC: PostCellDelegate {
    func didTapComment(for post: Post) {
        navigateToPostDetails(for: post)
    }
}
