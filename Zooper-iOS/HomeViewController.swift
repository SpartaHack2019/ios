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

    @IBOutlet weak var love: UIImageView!
    var postsData = [PostModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.swipeableCardView.dataSource = self

        loadPosts()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 30)!]
        scheduledTimerWithTimeInterval()
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
    var timer = Timer()
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer =  Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { (timer) in
            self.updateCounting()
        }
    }
    var count = 0;
    func updateCounting(){
        love.isHidden = lovedit.lover
        if(!lovedit.lover && count >= 1){
            lovedit.lover = true
            count = 0
        }
        else if(!lovedit.lover){
            count += 1
        }
    }

}
struct lovedit {
    static var lover = true
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
