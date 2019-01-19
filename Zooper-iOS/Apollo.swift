//
//  Apollo.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/19/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import Foundation
import Apollo

class Apollo {
    static let shared = Apollo()

    let client: ApolloClient

    init() {
        client = ApolloClient(url: URL(string: "http://35.22.32.21:1721/graphql")!)
    }
}
