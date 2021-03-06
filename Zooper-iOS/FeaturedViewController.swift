//
//  FeaturedViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/20/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentView: UISegmentedControl!

    var postsData = [PostModel]() {
        didSet {
            updateCurrentModels()
        }
    }
    var currentModels = [PostModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosts()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: "PostCellView", bundle: nil),
            forCellWithReuseIdentifier: "postCell"
        )

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 30)!]

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadPosts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }

        if segue.identifier == "PostDetail" {
            let destiation = segue.destination as! PostDetailViewController
            destiation.viewModel = currentModels[indexPath[0].row]
        }
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
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        updateCurrentModels()
    }

    func updateCurrentModels() {
        guard postsData.count >= 30 else { return }

        switch segmentView.selectedSegmentIndex {
        case 0:
            print("today")
            currentModels = postsData[0..<9].compactMap({$0})
        case 1:
            print("week")
            currentModels = postsData[9..<18].compactMap({$0})
        case 2:
            print("month")
            currentModels = postsData[18..<27].compactMap({$0})
        default:
            break
        }
        self.currentModels.sort(by: { (pm1, pm2) -> Bool in
            return pm1.likes ?? 0 > pm2.likes ?? 0
        })
        collectionView.reloadData()
    }

    
}

extension FeaturedViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PostDetail", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let columns: CGFloat = 3
            let margin = layout.sectionInset.left + layout.sectionInset.right
                + (layout.minimumLineSpacing * (columns - 1))
            let cellWidth = (collectionView.frame.size.width - margin) / columns
            let cellHeight = cellWidth * 161.0 / 116.0

            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize(width: 0, height: 0)
    }
}

extension FeaturedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard currentModels.indices.contains(indexPath.row) else { return UICollectionViewCell() }

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? PostCell {
            let post = currentModels[indexPath.row]
            cell.imageURL = URL(string: ConfigURL.media + post.imagePath)
            cell.likesLabel.text = String(post.likes ?? 0)
            return cell
        }
        return UICollectionViewCell()
    }
}
