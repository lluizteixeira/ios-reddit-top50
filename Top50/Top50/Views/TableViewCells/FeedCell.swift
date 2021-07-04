//
//  FeedCell.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 02/07/21.
//

import UIKit

class FeedCell: UITableViewCell {
    
    static let identifer = "feedCell"
    
    @IBOutlet weak var readBulletView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var post: Post? {
        didSet {
            authorLabel.text = post?.author
            createdLabel.text = (post?.created ?? 0).toDate().timeAgo()
            
            if post?.imageFile == nil {
                thumbnailImageView.imageFromUrl(post?.thumbnail ?? "") { (image) in
                    self.post?.imageFile = image
                }
            } else {
                thumbnailImageView.image = post?.imageFile
            }
            
            titleLabel.text = post?.title
            commentsLabel.text = String("\(String(post?.num_comments ?? 0)) comments")
            
            readBulletView.isHidden = !(post?.isNew ?? true)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
