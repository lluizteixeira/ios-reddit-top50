//
//  PostViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var post: Post? {
        didSet {
            reloadUI()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.isHidden = post == nil
    }
    
    func reloadUI() {
        loadViewIfNeeded()
        //self.avatarImageView.image
        authorLabel.text = post?.author
        createdLabel.text = String(post?.created ?? 0)
        titleLabel.text = post?.title
        
        if post?.imageFile == nil {
            thumbnailImageView.imageFromUrl(post?.thumbnail ?? "") { (image) in
                self.post?.imageFile = image
            }
        } else {
            thumbnailImageView.image = post?.imageFile
        }
        
        self.view.isHidden = post == nil
    }

}

extension PostViewController: FeedViewControllerDelegate {
  func selectPost(_ post: Post) {
    self.post = post
  }
}
