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
            //self.avatarImageView.image
            authorLabel.text = post?.author
            createdLabel.text = String(post?.created ?? 0)
            //thumbnailImageView
            titleLabel.text = post?.title
            commentsLabel.text = String(post?.num_comments ?? 0)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
