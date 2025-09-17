//
//  APIClient.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import Foundation
import Combine

protocol APIClient {
    func request<T: Decodable>(_ endpoint: URL) -> AnyPublisher<T, Error>
}

final class DefaultAPIClient: APIClient {
    func request<T: Decodable>(_ endpoint: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: endpoint)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // results on main thread
            .eraseToAnyPublisher()
    }
}
