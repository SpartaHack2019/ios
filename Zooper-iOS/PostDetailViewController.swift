//
//  PostDetailViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/20/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: PostModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: "PostCellView", bundle: nil),
            forCellWithReuseIdentifier: "postCell"
        )
    }

    
}

extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let margin = layout.sectionInset.left + layout.sectionInset.right
            let cellWidth = collectionView.frame.size.width - margin
            let cellHeight = cellWidth * 161.0 / 116.0

            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize(width: 0, height: 0)
    }
}

extension PostDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? PostCell {
            cell.imageURL = URL(string: ConfigURL.media + viewModel.imagePath)
            cell.likesLabel.text = String(viewModel.likes ?? 0)
            cell.descriptionLabel.text = viewModel.description
            cell.descriptionLabel.isHidden = false
            return cell
        }
        return UICollectionViewCell()
    }
}
