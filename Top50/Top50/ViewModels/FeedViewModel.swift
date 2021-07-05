//
//  FeedViewModel.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import Combine

class FeedViewModel {

    var feed: [PostContainer] = []
    var hasLoaded: Bool = false
    var after: String = ""
    
    var cancellables = Set<AnyCancellable>()
        
    /// getFeed - Get remote feed from feedService and configures viewModel `feed`.
    ///
    /// ```
    /// getFeed()
    /// ```
    ///
    /// - Parameter onComplete: returns API results
    /// - Returns: an array of posts in `feed`.
    func getFeed(onComplete: @escaping (_ error: String?) -> Void) {
        
        FeedService.get(self.after).sink { (completion) in
            #if DEBUG
            print(completion)
            #endif
        } receiveValue: { [weak self] feed in
            
            guard let self = self else {
                onComplete(nil)
                return                
            }
            
            //set that the first feed load happened
            self.hasLoaded = true
            
            //if after is set then append next page otherwise it is firt page
            if self.after == "" {
                self.feed = feed.data?.children ?? []
            } else {
                self.feed.append(contentsOf: feed.data?.children ?? [])
            }
            
            //saves the id for pagination
            self.after = feed.data?.after ?? ""
                        
            onComplete(nil)
        }
        .store(in: &cancellables)
    }
    
    /// deletePostAt - remove on post at a specific index in `feed`.
    ///
    /// ```
    /// deletePostAt(index: 0)
    /// ```
    ///
    /// - Warning: The array must not be empty
    /// - Parameter index: array index for the post to be removed
    func deletePostAt(index: Int) {
        self.feed.remove(at: index)
    }
    
    /// deleteAllPosts - remove all posts in `feed`.
    ///
    /// ```
    /// deleteAllPost()
    /// ```
    ///
    func deleteAllPosts() {
        self.feed.removeAll()
        self.after = ""
    }
}
