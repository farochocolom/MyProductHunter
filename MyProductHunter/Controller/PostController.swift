//
//  ViewController.swift
//  MyProductHunter
//
//  Created by Fernando on 9/20/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PostController: UIViewController {
    
//    var posts = [Post]() {
//        didSet{
//            postsTable.reloadData()
//        }
//    }
    
    var posts = [Post]()
    @IBOutlet weak var postsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        postsTable.dataSource = self
        postsTable.delegate = self
        
        ProductService.getFeaturedProducts { (posts) in
            
            guard let postList = posts else {return}
            
            self.posts = postList
            for post in postList {
                print(post.name)
                print(post.tagline)
            }
            
            self.postsTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PostController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTable.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        var post = posts[indexPath.row]
        
        cell.nameLabel.text = post.name
        cell.taglineLabel.text = post.tagline
        
        ProductService.getPostImage(url: post.thumbnailUrl) { (image) in
            guard let img = image else {return}
            cell.thumbnailImange.image = img
        }
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension PostController: UITableViewDelegate {
    
}

