//
//  CommentsController.swift
//  MyProductHunter
//
//  Created by Fernando on 9/22/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class CommentsController: UIViewController {

    @IBOutlet weak var commentsTable: UITableView!
    
    var post: Post!
    var comments = [Comment]() {
        didSet{
            commentsTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(post.id)
        CommentsService.getCommentsForPost(withId: post.id) { (commentList) in
            guard let comments = commentList else {return}
            self.comments = comments
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CommentsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.section]
        
        switch indexPath.row {
        case 0:
            
            let cell = commentsTable.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.commentBodyLabel.text = comment.body
            
            return cell
            
            
        case 1:
            
            let cell = commentsTable.dequeueReusableCell(withIdentifier: "CommentFooterCell", for: indexPath) as! CommentFooterCell
            
            cell.postedByLabel.text = "Posted by: \(comment.postedByUsername!)"
            
            return cell
            
            
        default:
            fatalError("Error: unexpected indexPath.")
        }
    }
}
