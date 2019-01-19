//
//  ViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/19/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var postsData = [PostModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosts()
    }

    func loadPosts() {
        let query = AllPostsQuery()
        Apollo.shared.client.fetch(query: query) { (results, error) in
            if let posts = results?.data?.allPosts?.compactMap({$0}) {
                self.postsData = posts.map(PostModel.init)
            } else if let error = error {
                print("Error loading data \(error)")
            }
        }
        print(postsData)
    }

}

