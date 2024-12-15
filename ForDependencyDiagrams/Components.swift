//
//  Components.swift
//  ForDependencyDiagrams
//
//  Created by Meharoof Najeeb on 15/12/2024.
//

import UIKit

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { loadedItems in
            // update UI
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do some action
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do some action
    }
}

struct Reachability {
    static let isNetworkAvailable = false
}

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    let local: LocalFeedLoader
    let remote: RemoteFeedLoader
    
    init(local: LocalFeedLoader, remote: RemoteFeedLoader) {
        self.local = local
        self.remote = remote
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        let load = Reachability.isNetworkAvailable ? remote.loadFeed : local.loadFeed
        load(completion)
    }
}
