//
//  Post.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
