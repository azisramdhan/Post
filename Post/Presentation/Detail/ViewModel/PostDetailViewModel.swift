//
//  PostDetailViewModel.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Combine

final class PostDetailViewModel {
    private let postUseCase: PostUseCase
    private let postId: Int
    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var post: Post?
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading: Bool = false

    init(postId: Int, postUseCase: PostUseCase) {
        self.postId = postId
        self.postUseCase = postUseCase
    }

    func loadPostDetail() {
        isLoading = true
        postUseCase.fetchPostDetail(id: postId)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] post in
                self?.post = post
            }
            .store(in: &cancellables)
    }
}
