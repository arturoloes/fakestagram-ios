//
//  ItemStorage.swift
//  fakestagram
//
//  Created by LuisE on 3/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ItemStorage<T> where T: Codable {
    public var item: T?
    private let archive: CodableStorage<T>
    
    init(filename: String) {
       archive = CodableStorage<T>(filename: filename)
        item = archive.load()
    }
    
    func save() {
        guard let payload = item else { return }
        _ = archive.save(data: payload)
    }
}
