//
//  PostModel.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/19/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import Foundation
import UIKit

class PostModel {
    var id: String
    var imagePath: String
    var description: String
    var adoption: Bool
    var adoptionURL: String?

    init(post: AllPostsQuery.Data.AllPost) {
        id = post.id
        imagePath = post.image
        description = post.description
        adoption = post.adoption
        adoptionURL = post.adoptionUrl
    }
}
