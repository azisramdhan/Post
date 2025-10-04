//
//  DIContainer.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import UIKit

final class DIContainer {
    // MARK: - Shared
    private lazy var apiClient: APIClient = DefaultAPIClient()

    // MARK: - DataSources
    private lazy var postRemoteDataSource: PostRemoteDataSource =
        PostRemoteDataSourceImpl(apiClient: apiClient)

    // MARK: - Repositories
    private lazy var postRepository: PostRepository =
        PostRepositoryImpl(remoteDataSource: postRemoteDataSource)

    // MARK: - Use Cases
    private lazy var postUseCase: PostUseCase =
        PostUseCaseImpl(repository: postRepository)

    // MARK: - ViewModels
    func makePostListViewModel() -> PostListViewModel {
        PostListViewModel(postUseCase: postUseCase)
    }

    func makePostDetailViewModel(postId: Int) -> PostDetailViewModel {
        PostDetailViewModel(postId: postId, postUseCase: postUseCase)
    }

    // MARK: - ViewControllers
    func makePostListViewController() -> UIViewController {
        let vc = PostListViewController()
        vc.viewModel = makePostListViewModel()
        vc.onPostSelected = { [weak self, weak vc] postId in
            guard let self, let vc else { return }
            let viewController = self.makePostDetailViewController(postId: postId)
            vc.navigationController?.pushViewController(viewController, animated: true)
        }
        return vc
    }

    func makePostDetailViewController(postId: Int) -> UIViewController {
        let vc = PostDetailViewController()
        vc.viewModel = makePostDetailViewModel(postId: postId)
        return vc
    }
}
