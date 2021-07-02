//
//  FeedViewModel.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation

class FeedViewModel {

    var feed: [Post] = []
    var limit: Int = 10
    
    func getFeed(success: @escaping () -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        FeedService.get(onSuccess: {
            
        }, onFail: { (error) in
            
        })
    }
    
    func deletePost(postId: String, success: @escaping () -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        
    }
}
