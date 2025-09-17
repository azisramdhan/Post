//
//  PostRepository.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Combine

protocol PostRepository {
    func fetchPosts() -> AnyPublisher<[Post], Error>
    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error>
}
