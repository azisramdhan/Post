//
//  PostRemoteDataSourceImpl.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Foundation
import Combine

final class PostRemoteDataSourceImpl: PostRemoteDataSource {
    private let apiClient: APIClient
    private let baseURL = "https://jsonplaceholder.typicode.com"

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "\(baseURL)/posts") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return apiClient.request(url)
    }

    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error> {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return apiClient.request(url)
    }
}
