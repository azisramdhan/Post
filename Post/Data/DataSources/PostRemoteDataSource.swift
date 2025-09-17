//
//  PostRemoteDataSource.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Combine

protocol PostRemoteDataSource {
    func fetchPosts() -> AnyPublisher<[Post], Error>
    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error>
}
