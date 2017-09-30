//
//  FeedViewController.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    var postCollectionView: UICollectionView!
    var posts: [Post] = []
    var auth = Auth.auth()
    var postsRed: DatabaseReference = Database.database().reference().child("Posts")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: User?
    var clickedPost: Post!
    var details: Post!
    
    let samplePost = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        posts.append(samplePost)
        fetchUser {
            self.fetchPosts() {
                print("done")
                activityIndicator.stopAnimating()
            }
        }
        //self.setupNewPostView()
        //self.setupButton()
        self.setupCollectionView()
        self.setupNavBar()
    }
    
    func fetchPosts(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            if let postDict = snapshot.value {
                let post = Post(id: snapshot.key, postDict: postDict as? [String: Any])
                self.posts.append(post)
                
                var indexPaths = Array<IndexPath>()
                let index = self.posts.index(where: {$0.id == post.id})
                let indexPath = IndexPath(item: index!, section: 0)
                indexPaths.append(indexPath)
                
                /*DispatchQueue.main.async {
                    self.postCollectionView.performBatchUpdates({void in
                        self.postCollectionView.insertItems(at: indexPaths)
                    }, completion: nil)
                }*/
            }
            
            withBlock()
        })
    }
    
    func fetchUser(withBlock: @escaping () -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Users").child((self.auth.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            self.currentUser = user
            withBlock()
            
        })
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.10))
        let navItem = UINavigationItem(title: "Feed");
        let addPostButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPost))
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navItem.leftBarButtonItem = logOutButton
        navItem.rightBarButtonItem = addPostButton
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func addNewPost() {
        performSegue(withIdentifier: "toNewPost", sender: self)
    }
    
    func logOut() {
        print("logging out")
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    func setupCollectionView() {
        let frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 20)
        let cvLayout = UICollectionViewFlowLayout()
        postCollectionView = UICollectionView(frame: frame, collectionViewLayout: cvLayout)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "post")
        
        postCollectionView.backgroundColor = UIColor.white
        view.addSubview(postCollectionView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! PostCollectionViewCell
        cell.awakeFromNib()
        let postInQuestion = posts[indexPath.row]
        
        if let name = postInQuestion.poster {
            cell.name.text = name
        }
        
        if let text = postInQuestion.text {
            cell.text.text = text
        }
        
        if let url = postInQuestion.imageUrl {
            do {
                try cell.image.image = UIImage(data:Data(contentsOf: URL(string: url)!))
            } catch {
                cell.image.image = #imageLiteral(resourceName: "fun")
            }
        } else {
            NSLog("No image url found")
        }
        
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: postCollectionView.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        details = posts[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.post = details
        }
    }

    
    
}







    /*var newPostView: UITextField!
    var newPostButton: UIButton!
    var postCollectionView: UICollectionView!
    var posts: [Post] = []
    var auth = Auth.auth()
    var postsRef: DatabaseReference = Database.database().reference().child("Posts")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: User?
    var navBar: UINavigationBar!
    var testButton: UIButton!
    
    
    //For sample post
    let samplePost = Post()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        posts.append(samplePost)
        fetchUser {
            self.fetchPosts() {
                print("done")
                if self.newPostView != nil {
                    self.newPostView.removeFromSuperview()
                }
                
                
                
                
                activityIndicator.stopAnimating()
            }
        }
        self.setupNewPostView()
        self.setupButton()
        
        self.setupCollectionView()
        self.setupNavBar()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.10))
        let navItem = UINavigationItem(title: "Feed");
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navItem.rightBarButtonItem = logOutButton
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func logOut() {
        print("logging out")
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    func setupNewPostView() {
        newPostView = UITextField(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.3 * UIScreen.main.bounds.height))
        newPostView.layoutIfNeeded()
        newPostView.layer.shadowRadius = 2.0
        newPostView.layer.masksToBounds = true
        newPostView.placeholder = "Write a new post..."
        view.addSubview(newPostView)
    }
    
    func setupButton() {
        newPostButton = UIButton(frame: CGRect(x: 10, y: newPostView.frame.maxY + 10, width: UIScreen.main.bounds.width - 20, height: 50))
        newPostButton.setTitle("Add Post", for: .normal)
        newPostButton.setTitleColor(UIColor.blue, for: .normal)
        newPostButton.layoutIfNeeded()
        newPostButton.layer.borderWidth = 2.0
        newPostButton.layer.cornerRadius = 3.0
        newPostButton.layer.borderColor = UIColor.blue.cgColor
        newPostButton.layer.masksToBounds = true
        newPostButton.addTarget(self, action: #selector(addNewPost), for: .touchUpInside)
        view.addSubview(newPostButton)
    }
    
    //y: newPostButton.frame.maxY + 10
    func setupCollectionView() {
        let frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - newPostButton.frame.maxY - 20)
        let cvLayout = UICollectionViewFlowLayout()
        postCollectionView = UICollectionView(frame: frame, collectionViewLayout: cvLayout)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "post")
        
        postCollectionView.backgroundColor = UIColor.white
        view.addSubview(postCollectionView)
        
        
    }
    
    func addNewPost(sender: UIButton!) {
        //TODO: Implement using Firebase!
        /*let postText = newPostView.text!
        newPostView.removeFromSuperview()
        let newPost = ["text": postText, "poster": currentUser?.name, "imageUrl": currentUser?.imageUrl, "posterId": currentUser?.id] as [String : Any]
        let key = postsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": newPost]
        postsRef.updateChildValues(childUpdates)*/
        performSegue(withIdentifier: "toNewPost", sender: self)
    }
    
    func fetchPosts(withBlock: @escaping () -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            self.posts.append(post)
            
            withBlock()
        })
    }
    
    func fetchUser(withBlock: @escaping () -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Users").child((self.auth.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            self.currentUser = user
            withBlock()
            
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! PostCollectionViewCell
        cell.awakeFromNib()
        let postInQuestion = posts[indexPath.row]
        cell.postText.text = postInQuestion.text
        cell.posterText.text = postInQuestion.poster
        
        if indexPath.row == 0 {
            //postInQuestion.getProfilePic {
                //cell.profileImage.image = postInQuestion.image
                cell.profileImage.image = #imageLiteral(resourceName: "fun")
            
        }
        else {
            postInQuestion.getProfilePic {
                cell.profileImage.image = postInQuestion.image
            }
        }
        
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: postCollectionView.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    
}*/


