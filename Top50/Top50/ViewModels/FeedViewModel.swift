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
    
    var cancellables = Set<AnyCancellable>()
    
    func getFeed(success: @escaping () -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        
        FeedService.get().sink { (completion) in
            print(completion)
        } receiveValue: { (feed) in
            self.feed = feed.data?.children ?? []
            success()
        }
        .store(in: &cancellables)
    }
    
    func deletePost(index: Int, success: @escaping () -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        self.feed.remove(at: index)
        success()
    }
}
