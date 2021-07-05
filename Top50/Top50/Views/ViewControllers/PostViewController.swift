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
    
    /// post - main object for fill view content
    ///
    /// ```
    /// post: Post?
    /// ```
    ///
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
    
    /// reloadUI - fill view outlet properties
    ///
    /// ```
    /// reloadUI()
    /// ```
    func reloadUI() {
        loadViewIfNeeded()
        
        ///if post is nil the view content must be hidden
        guard let myPost = self.post else {
            self.view.isHidden = post == nil
            return
        }
        
        authorLabel.text = myPost.author
        createdLabel.text = myPost.created.toDate().timeAgo()
        titleLabel.text = myPost.title
        
        if myPost.imageFile == nil {
            thumbnailImageView.image = nil
            thumbnailImageView.imageFromUrl(post?.thumbnail ?? "") { (image) in
                myPost.imageFile = image
            }
        } else {
            thumbnailImageView.image = myPost.imageFile
        }
        
        self.view.isHidden = false
    }
    
    /// doShare - share post content
    ///
    /// ```
    /// doShare()
    /// ```
    ///
    @IBAction func doShare(_ sender: Any) {
        if let image = post?.imageFile {
            
            let title = post?.title ?? ""                        
        
            let shareAll = [image, title] as [Any]
                                
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.excludedActivityTypes = [.print,.airDrop,.assignToContact,.postToTencentWeibo]
        
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            self.alert(title: "Error sharing content", error: "No Image loaded for this post.")
        }
    }
    
}

/// Feed delegate for post content viewer
extension PostViewController: FeedViewControllerDelegate {
    func selectPost(_ post: Post) {
        self.post = post
    }
    
    func dismiss() {
        self.post = nil
    }
}
