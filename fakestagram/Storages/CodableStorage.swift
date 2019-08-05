//
//  CodableStorage.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 4.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CodableStorage<T> where T: Codable {
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

//class CodableStorage<T> where T: Codable {
//    let filename: String
//    let dataContainer = DataContainer.permanent
//
//    init(filename: String) {
//        self.filename = filename
//    }
//
//    func load() -> T? {
//        guard let data = dataContainer.load(filename: filename) else {
//            return nil
//        }
//        do {
//            return try JSONDecoder().decode(T.self, from: data)
//        } catch let err {
//            print("Could not decode data: \(err.localizedDescription)")
//            return nil
//        }
//    }
//
//    func save(data dataSource: T) -> Bool {
//        guard let data = try? JSONEncoder().encode(dataSource) else {
//            return false
//        }
//        return dataContainer.save(data: data, in: filename)
//    }
//}
