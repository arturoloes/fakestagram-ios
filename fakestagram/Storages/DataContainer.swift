//
//  DataContainer.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 4.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

enum DataContainer {
    case cache
    case permanent
    
    var baseUrl: URL {
        switch self {
        case .cache:
            return StorageType.cache.url
        case .permanent:
            return StorageType.permanent.url
        }
    }
    
    func fileUrl(for filename: String) -> URL? {
        var fileUrl = baseUrl
        fileUrl.appendPathComponent(filename)
        return fileUrl
    }
    
    func load(filename: String) -> Data? {
        guard let url = fileUrl(for: filename) else {
            print("Unable to load url")
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    func save(data: Data, in filename: String) -> Bool {
        guard let url = fileUrl(for: filename) else {
            print("Unable to load url")
            return false
        }
        do {
            try data.write(to: url)
            return true
        } catch let err {
            print("Unable to write on disk: \(err.localizedDescription)")
            return false
        }
    }
}
