//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 3.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var previewCollectionPosts: UICollectionView!
    
    var posts = [Post]()
    let reuseIdentifier = "postThumbnailCell"
    
    let client = ProfilePostClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        loadAuthor()
        
        //delegatesAndXib()
        //getProfileInfo()
        //setConstraints()
        
        client.show { [weak self] posts in
            self?.posts = posts
            self?.previewCollectionPosts.reloadData()
        }
       // authorView.author = Author(name: "jojo")
    }

    private func configCollectionView() {
        previewCollectionPosts.delegate = self
        previewCollectionPosts.dataSource = self
        let postThumbnailViewCellXib = UINib(nibName: String(describing: PostThumbnailCollectionViewCell.self), bundle: nil)
        previewCollectionPosts.register(postThumbnailViewCellXib, forCellWithReuseIdentifier: PostThumbnailCollectionViewCell.reuseIdentifier)
        
    }
    
    func loadAuthor() {
        
        guard let acc = AccountRepo.shared.load() else { return }
        authorView.author = acc.toAuthor()
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = previewCollectionPosts.frame.width / 3.0
        print(size)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostThumbnailCollectionViewCell
        let post = posts[indexPath.row]
        //        print(post.title)
        //        cell.backgroundColor = .red
        cell.post = post
        return cell
        
    }
    
    
}
    



    /*
    func getProfileInfo() {
        guard let account = AccountRepo.shared.load() else { return }
        authorView.author = account.toAuthor()
    }
    
    func delegatesAndXib() {
        previewCollectionPosts.delegate = self
        previewCollectionPosts.dataSource = self
        
        let postThumbnailCell = UINib(nibName: String(describing: PostThumbnailCollectionViewCell.self), bundle: nil)
        previewCollectionPosts.register(postThumbnailCell, forCellWithReuseIdentifier: PostThumbnailCollectionViewCell.reuseIdentifier)
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setConstraints() {
        previewCollectionPosts.translatesAutoresizingMaskIntoConstraints = false
        previewCollectionPosts.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        previewCollectionPosts.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -1.0).isActive = true
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPhat: IndexPath) -> CGSize {
        let size = view.frame.width / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as! PostThumbnailCollectionViewCell
        cell.post = posts[indexPath.row]
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
*/

