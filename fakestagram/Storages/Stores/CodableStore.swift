//
//  CodableStore.swift
//  fakestagram
//
//  Created by LuisE on 3/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CodableStore<T> where T: Codable {
    let filename: String
    
    var fileUrl: URL? {
        var fileUrl = StorageType.permanent.url
        fileUrl.appendPathComponent(filename)
        return fileUrl
    }
    
    func load() -> T? {
        guard let path = self.fileUrl, let data = try? Data(contentsOf: path) else {
            print("Could not load data from \(String(describing: self.fileUrl))")
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let err {
            print("Could not decode data: \(err.localizedDescription)")
            return nil
        }
    }
    
    func save(data dataSource: T) {
        guard let data = try? JSONEncoder().encode(dataSource), let path = self.fileUrl else { return }
        do {
            try data.write(to: path)
        } catch let err {
            print("Could not save file: \(err.localizedDescription)")
        }
    }
}
