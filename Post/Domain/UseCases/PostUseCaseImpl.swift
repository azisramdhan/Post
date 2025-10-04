//
//  PostUseCaseImpl.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Combine

final class PostUseCaseImpl: PostUseCase {
    private let repository: PostRepository

    init(repository: PostRepository) {
        self.repository = repository
    }

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        repository.fetchPosts()
    }

    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error> {
        repository.fetchPostDetail(id: id)
    }
}
