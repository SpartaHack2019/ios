//
//  ProfileViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/20/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var postsData = [PostModel]()

    @IBOutlet weak var collectionView: UICollectionView!

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

        if segue.identifier == "PostDetail2" {
            let destiation = segue.destination as! PostDetailViewController
            destiation.viewModel = postsData[indexPath[0].row]
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
            self.postsData.sort(by: { (pm1, pm2) -> Bool in
                return pm1.id > pm2.id
            })
            self.postsData = self.postsData[0..<6].compactMap({$0})
            self.collectionView.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PostDetail2", sender: nil)
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

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard postsData.indices.contains(indexPath.row) else { return UICollectionViewCell() }

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? PostCell {
            let post = postsData[indexPath.row]
            cell.imageURL = URL(string: ConfigURL.media + post.imagePath)
            cell.likesLabel.text = String(post.likes ?? 0)
            return cell
        }
        return UICollectionViewCell()
    }
}

