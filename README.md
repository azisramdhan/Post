# Post

A sample iOS application demonstrating **Clean Architecture** with **MVVM**, built using **UIKit** and **Combine**.  
It fetches posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) and displays them in a list with detail view support.

---

## Features

- Fetch posts from API using `URLSession` + `Combine`  
- Pull-to-refresh for post list  
- MVVM with dependency injection (manual DI)  
- Clean Architecture layers: **Application, Data, Domain, Presentation**  
- UIKit-based UI following Human Interface Guidelines (HIG)  
- Error handling and loading states

---

## Project Structure

The project follows a **Clean Architecture + MVVM** approach:

```
Post
├── Application
│   ├── Constants
│   │   └── UIConstants.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   ├── Info.plist
│   │   └── LaunchScreen.storyboard
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── DIContainer.swift
│
├── Data
│   ├── DataSources
│   │   ├── PostRemoteDataSource.swift
│   │   └── PostRemoteDataSourceImpl.swift
│   ├── Network
│   │   └── APIClient.swift
│   └── Repositories
│       └── PostRepositoryImpl.swift
│
├── Domain
│   ├── Entities
│   │   └── Post.swift
│   ├── Repositories
│   │   └── PostRepository.swift
│   └── UseCases
│       ├── PostUseCase.swift
│       └── PostUseCaseImpl.swift
│
├── Presentation
│   ├── Detail
│   │   ├── View
│   │   │   └── PostDetailViewController.swift
│   │   └── ViewModel
│   │       └── PostDetailViewModel.swift
│   └── List
│       ├── View
│       │   └── PostListViewController.swift
│       └── ViewModel
│           └── PostListViewModel.swift
│
└── PostTests
```

- **Application**: Entry points, DI setup, and constants.  
- **Data**: Handles data access (network, persistence) and implements repositories.  
- **Domain**: Business logic (Entities, Repositories contracts, UseCases).  
- **Presentation**: UIKit + Combine-based MVVM (Views, ViewModels).  
- **PostTests**: Unit tests.

---

## Requirements

- Xcode 15+  
- iOS 13.0+  
- Swift 5.9+

---

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/PostApp.git
   cd PostApp
   ```

2. Open `Post.xcodeproj` in Xcode.

3. Build and run on Simulator or a device.

---

## API

This project uses the free [JSONPlaceholder](https://jsonplaceholder.typicode.com/) API.

- **GET** `/posts` → Returns a list of posts

---

## License

This project is licensed under the MIT License.
