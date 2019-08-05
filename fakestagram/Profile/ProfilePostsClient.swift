//
//  ProfilePostsClient.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 5/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ProfilePostClient: RestClient<[Post]>{
    convenience init(){
        self.init(client: Client(), path: "/api/profile/posts")
    }
}
