//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "postViewCell"
    public var row: Int = -1
    public var post: Post? {
        didSet { updateView() }
    }

    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var likesView: UILabel!
    @IBOutlet weak var commentsView: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    func updateView() {
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
        authorView.author = post.author
        descriptionView.text = post.title
        likesView.text = post.likesCountText()
        commentsView.text = post.commentsCountText()
    }
    
    @IBAction func tapLike( _ sender:Any ){
        guard let post = post else { return }
        let client = LikeUpdaterClient(post: post, row: row)
        self.post = client.call()
    }

}
