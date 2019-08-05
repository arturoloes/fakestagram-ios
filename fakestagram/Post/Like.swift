//
//  Like.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 26.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Codable {
    let author: Author?
    let createdAt: String
    let updatedAt: String
}
