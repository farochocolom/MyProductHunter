//
//  PostCell.swift
//  MyProductHunter
//
//  Created by Fernando on 9/22/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var thumbnailImange: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        nameLabel.text = post.name
        taglineLabel.text = post.tagline
        
        setupThumbnailImage(post: post)
    }
    
    func setupThumbnailImage(post: Post) {
        guard let thumbnailImageUrl = post.thumbnailUrl else {return}
        
        thumbnailImange.loadImageFromUrlString(urlString: thumbnailImageUrl)
    }

}
