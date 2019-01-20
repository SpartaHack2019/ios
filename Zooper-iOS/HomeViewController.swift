//
//  ViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/19/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SDWebImage
class HomeViewController: UIViewController, SwipeableCardViewDataSource {

    @IBOutlet weak var swipeableCardView: SwipeableCardViewContainer!

    var postsData = [PostModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.swipeableCardView.dataSource = self

        loadPosts()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 30)!]
    }

    func loadPosts() {
        let query = AllPostsQuery()
        Apollo.shared.client.fetch(query: query) { (results, error) in
            if let posts = results?.data?.allPosts?.compactMap({$0}) {
                self.postsData = posts.map(PostModel.init)
            } else if let error = error {
                print("Error loading data \(error)")
            }
            self.swipeableCardView.reloadData()
        }
    }

}

extension HomeViewController {

    func numberOfCards() -> Int {
        return postsData.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        guard postsData.indices.contains(index) else { return SwipeableCardViewCard() }

        let post = postsData[index]
        let image = URL(string: ConfigURL.media + post.imagePath)

        let url = URL(string: post.adoptionURL ?? "")
        let viewModel = SampleSwipeableCellViewModel(description: post.description,
                                                     adoptionURL: url,
                                                     image: image!)
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }

}
