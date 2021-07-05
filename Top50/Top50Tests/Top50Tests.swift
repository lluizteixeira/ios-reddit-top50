//
//  Top50Tests.swift
//  Top50Tests
//
//  Created by Luiz Felipe Prestes Teixeira on 29/06/21.
//

import XCTest
@testable import Top50

var viewModel: FeedViewModel!

class Top50Tests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = FeedViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }

    // testing view model initialization
    func testEmptyFeed() {
        viewModel = FeedViewModel()
        XCTAssert(viewModel.feed.count == 0, "Feed must start empty")
        XCTAssert(viewModel.after == "", "Feed must start with no pagination id")
    }
    
    // testing view model loading remote feed
    func testLoadFeedService() {
        viewModel = FeedViewModel()
        
        let promise = expectation(description: "LOADAPI")
        
        viewModel.getFeed { (error) in
            XCTAssert(viewModel.feed.count > 0, "Feed must have posts")
            promise.fulfill()
        }
        
        self.wait(for: [promise], timeout: TimeInterval(10))
    }
    
    // testing view model dismissing post
    func testDismissPostFeed() {
        viewModel = FeedViewModel()
        
        viewModel.feed = Util.readLocalFeedFile()
        
        XCTAssert(viewModel.feed.count == 2, "Local Feed must have 2 posts")
        
        viewModel.deletePostAt(index: 0)
        
        XCTAssert(viewModel.feed.count == 1, "Feed must have 1 posts after dismiss one")
    }
    
    // testing view model dismissing all feed
    func testDismissAllFeed() {
        viewModel = FeedViewModel()
        
        viewModel.feed = Util.readLocalFeedFile()
        
        XCTAssert(viewModel.feed.count == 2, "Local Feed must have 2 posts")
        
        viewModel.deleteAllPosts()
        
        XCTAssert(viewModel.feed.count == 0, "Feed must have no posts after dismiss all")
    }
    
    // testing post object
    func testFeedPost() {
        viewModel = FeedViewModel()
        
        viewModel.feed = Util.readLocalFeedFile()
        
        let postContainer = viewModel.feed[0]
        let post = postContainer.data
        
        XCTAssert(post?.title != nil, "Post must have a title")
        XCTAssert(post?.num_comments != nil, "Post must number of comments")
        XCTAssert(post?.created != nil, "Post must a creation date")
        XCTAssert(post?.author != nil, "Post must a author")
    }
    
    // testing post nil
    func testFeedNilPost() {
        let postViewController = PostViewController()
        postViewController.post = nil
        XCTAssert(postViewController.view.isHidden == true, "Post detail must not show content view if post is nil")
    }

    // testing feed decode/parse local json 
    func testLocalFeedPerformance() throws {
        viewModel = FeedViewModel()
                
        self.measure {
            viewModel.feed = Util.readLocalFeedFile()
            XCTAssert(viewModel.feed.count == 2, "measuring performance to decode json")
        }
    }
}
