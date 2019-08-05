//
//  ImageStorage.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 4.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class ImageStorage {
    let filename: String
    let dataContainer = DataContainer.permanent
    
    init(filename: String) {
        self.filename = filename
    }
    
    func load() -> UIImage? {
        guard let data = dataContainer.load(filename: filename) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    func save(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 0.95) else {
            print("Unable to load jpeg data representation")
            return false
        }
        return dataContainer.save(data: data, in: filename)
    }
}
