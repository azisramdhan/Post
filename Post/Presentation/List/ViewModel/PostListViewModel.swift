//
//  PostListViewModel.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Combine

final class PostListViewModel {
    private let postUseCase: PostUseCase
    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var posts: [Post] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading: Bool = false

    init(postUseCase: PostUseCase) {
        self.postUseCase = postUseCase
    }

    func loadPosts() {
        isLoading = true
        postUseCase.fetchPosts()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}
