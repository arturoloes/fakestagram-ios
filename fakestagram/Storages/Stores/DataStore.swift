//
//  DataStore.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 26.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

enum DataStore {
    case cache
    case permanent
    
    var baseUrl:URL {
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
    
    func load(filename:String) -> Data? {
        guard let url = fileUrl(for: filename) else {
            print("Enable to load url")
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    //func save()
}
