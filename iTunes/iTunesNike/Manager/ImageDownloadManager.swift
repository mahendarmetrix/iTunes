//
//  ImageDownloadManager.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit
import CommonCrypto

typealias ImageResult = (UIImage?) -> ()


class ImageDownloadManager {
    
    
    func getImageData(urlStr : String?, completion: @escaping ImageResult) {
        let imgDownloadService = ImageDownloadService()
        DispatchQueue.global(qos: .background).async {
            
            imgDownloadService.getImageData(urlStr: urlStr) {[weak self] (data) in
                if let data = data{
                    self?.cacheImageData(urlStr: urlStr, data: data)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    
    func cacheImageData (urlStr : String?, data : Data){
        if let md5 = self.MD5(string: urlStr){
            let fileManager = FileManager.default
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                let fileURL = documentDirectory.appendingPathComponent(md5)
                
                try data.write(to: fileURL)
            } catch {
                print(error)
            }
        }
    }
    
    func getCachedImage(urlStr : String?) -> UIImage? {
        let md5 = self.MD5(string: urlStr)
        if let data = self.getDataFromMD5(urlMD5: md5){
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
    func getDataFromMD5(urlMD5 : String?) -> Data?{
        guard let urlMD5 = urlMD5  else {
            return nil
        }
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(urlMD5)
            return try Data(contentsOf: fileURL)
        } catch {
            print(error)
        }
        return nil
    }
    
    
    func MD5(string: String?) -> String? {
        guard let string = string  else {
            return nil
        }
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }
    
}
