//
//  PostDetailViewController.swift
//  Post
//
//  Created by Azis Ramdhan on 17/09/25.
//

import UIKit
import Combine

final class PostDetailViewController: UIViewController {
    var viewModel: PostDetailViewModel!

    private var cancellables = Set<AnyCancellable>()
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    private let refreshControl = UIRefreshControl()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        bindViewModel()

        viewModel.loadPostDetail()
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 12
        contentView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl

        contentView.addArrangedSubview(titleLabel)
        contentView.addArrangedSubview(bodyLabel)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])
    }

    @objc private func handleRefresh() {
        viewModel.loadPostDetail()
    }

    private func bindViewModel() {
        viewModel.$post
            .sink { [weak self] post in
                guard let self, let post else { return }
                self.titleLabel.text = post.title
                self.bodyLabel.text = post.body
                self.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] message in
                self?.refreshControl.endRefreshing()
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .dropFirst()
            .sink { [weak self] isLoading in
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
    }
}
