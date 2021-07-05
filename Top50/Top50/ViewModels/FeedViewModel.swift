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
    
    func getFeed(onComplete: @escaping (_ error: String?) -> Void) {
        
        FeedService.get(self.after).sink { (completion) in
            print(completion)
        } receiveValue: { (feed) in
            
            self.hasLoaded = true
            
            if self.after == "" {
                self.feed = feed.data?.children ?? []
            } else {
                self.feed.append(contentsOf: feed.data?.children ?? [])
            }
            
            self.after = feed.data?.after ?? ""
                        
            onComplete(nil)
        }
        .store(in: &cancellables)
    }
    
    func deletePost(index: Int) {
        self.feed.remove(at: index)
    }
    
    func deleteAllPosts() {
        self.feed.removeAll()
    }
}
