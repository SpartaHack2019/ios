//
//  PostCell.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/20/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageURL: URL? {
        didSet {
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
