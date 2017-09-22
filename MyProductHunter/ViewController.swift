//
//  ViewController.swift
//  MyProductHunter
//
//  Created by Fernando on 9/20/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ProductService.getFeaturedProducts { (posts) in
            
            guard let postList = posts else {return}
            
            for post in postList {
                print(post.name)
                print(post.tagline)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

