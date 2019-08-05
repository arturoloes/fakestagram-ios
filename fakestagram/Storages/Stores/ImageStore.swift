//
//  ImageStore.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 26.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageStore {
    let filename:String
    
    var fileUrl: URL? {
        var fileUrl = StorageType.permanent.url
        fileUrl.appendPathComponent(filename)
        return fileUrl
    }
    
    func load() -> UIImage? {
        guard let url = fileUrl, let data = try? Data(contentsOf: url) else {
            print("Unable to load url")
            return nil
        }
        return UIImage(data: data)
    }
    
    func save(image:UIImage?) -> Bool {
        guard let url = fileUrl else { return false }
        guard let data = image?.jpegData(compressionQuality: 0.95) else {
            print("Unable to lead jpeg data representation")
            return false
        }
        do {
            _ = try data.write(to: url)
            return true
        } catch let err {
            print("Unable to write on disk: \(err.localizedDescription)")
            return false
        }
    }
}
