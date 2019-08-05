//
//  PostThumbnailCollectionViewController.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 5/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    static let reuseIdentifier = "postThumbnailCell"
    
    var post: Post? {
        didSet { updateImageView() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateImageView() {
        guard let post = post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
    }
    
}
