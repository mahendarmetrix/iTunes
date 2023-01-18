//
//  ImageDownloadService.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit

class ImageDownloadService {
    typealias ImageResutl = (Data?) -> ()
    
    func getImageData(urlStr : String?, completion: @escaping ImageResutl) {
        
        
        guard let urlStr = urlStr else { return }
        
        guard let url = URL(string: urlStr) else { return }
        do {
            let data = try Data(contentsOf: url)
            completion(data)
        }
        catch {
            
        }
        
    }
}
