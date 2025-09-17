//
//  PostTests.swift
//  PostTests
//
//  Created by Azis Ramdhan on 17/09/25.
//

import XCTest
import Combine
@testable import Post

final class PostUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockRepository: MockPostRepository!
    private var sut: PostUseCase!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepository = MockPostRepository()
        sut = PostUseCaseImpl(repository: mockRepository)
    }

    override func tearDown() {
        cancellables = nil
        mockRepository = nil
        sut = nil
        super.tearDown()
    }

    func testFetchPostsReturnsData() {
        // Given
        let expectedPosts = [
            Post(id: 1, userId: 1, title: "Title 1", body: "Body 1"),
            Post(id: 2, userId: 1, title: "Title 2", body: "Body 2")
        ]
        mockRepository.stubbedPosts = expectedPosts

        let expectation = XCTestExpectation(description: "Fetch posts")

        // When
        sut.fetchPosts()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { posts in
                // Then
                XCTAssertEqual(posts.count, 2)
                XCTAssertEqual(posts.first?.title, "Title 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPostDetailReturnsCorrectPost() {
        // Given
        let expectedPost = Post(id: 99, userId: 1, title: "Detail Title", body: "Detail Body")
        mockRepository.stubbedPostDetail = expectedPost

        let expectation = XCTestExpectation(description: "Fetch post detail")

        // When
        sut.fetchPostDetail(id: 99)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { post in
                // Then
                XCTAssertEqual(post.id, 99)
                XCTAssertEqual(post.title, "Detail Title")
                XCTAssertEqual(post.body, "Detail Body")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: - Mock Repository
final class MockPostRepository: PostRepository {
    var stubbedPosts: [Post] = []
    var stubbedPostDetail: Post?

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        Just(stubbedPosts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchPostDetail(id: Int) -> AnyPublisher<Post, Error> {
        if let detail = stubbedPostDetail {
            return Just(detail)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "No Detail", code: -1))
                .eraseToAnyPublisher()
        }
    }
}
