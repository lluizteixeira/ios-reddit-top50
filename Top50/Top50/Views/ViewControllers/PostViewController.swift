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
        authorLabel.text = post?.author
        createdLabel.text = (post?.created ?? 0).toDate().timeAgo()
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

extension PostViewController: FeedViewControllerDelegate {
    func selectPost(_ post: Post) {
        self.post = post
    }
    
    func dismiss() {
        self.post = nil
    }
}
