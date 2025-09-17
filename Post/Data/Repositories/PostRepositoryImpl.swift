//
//  PostRepositoryImpl.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Foundation
import Combine

final class PostRepositoryImpl: PostRepository {
    private let remoteDataSource: PostRemoteDataSource

    init(remoteDataSource: PostRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        remoteDataSource.fetchPosts()
    }

    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error> {
        remoteDataSource.fetchPostDetail(id: id)
    }
}
