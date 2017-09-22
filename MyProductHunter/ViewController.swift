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
        let session = URLSession.shared
        let baseURL = URL(string: Constants.URLs.BASE_URL + Constants.URLs.MY_PROFILE + Constants.URLs.POSTS)!
        
        var request = URLRequest(url: baseURL)
        request.setValue("Bearer 0179e0017d2d4d388e62be3a6ddb5f5604c1512e6c47448fbd8d58ce6b2a82e7", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

