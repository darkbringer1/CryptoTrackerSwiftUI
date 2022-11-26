//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 26.11.2022.
//

import SwiftUI

class ImageCacheManager {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    class func setImagesToCache(object: UIImage, key: String) {
        imageCache.setObject(object, forKey: NSString(string: key))
    }
    
    class func returnImagesFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
}

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() {}
    
    
    func imageLoadingProcess(data: Data?, url: String) -> UIImage? {
        //if its cached, set image to image else next step --->>
        if let cachedImage = returnImageFromCache(imageUrl: url) {
            return cachedImage
        } else {
            return handleTaskResponse(data: data, imageUrl: url)
        }
    }
    
    /// Checking the image with a url and return the image
    private func handleTaskResponse(data: Data?, imageUrl: String) -> UIImage? {
        guard let data = data, let image = UIImage(data: data) else { return nil }
        
        //need to set image to cache if it is downloaded
        setImageToCache(key: imageUrl, object: image)
        
        //if there is an image, put it on the view with animation
        return image
    }
    
    //MARK: - SETTING IMAGE TO CACHE
    /// Setting downloaded image to cache
    /// - Parameter key: String that specifies the image name
    /// - Parameter object: UIImage that will be saved to the cache
    private func setImageToCache(key: String, object: UIImage) {
        debugPrint("downloading image with key: \(key)")
        ImageCacheManager.setImagesToCache(object: object, key: key)
    }
    
    //MARK: - RETURNING THE IMAGE FROM THE CACHE
    /// Getting downloaded image from cache
    /// - Parameter imageUrl: String that specifies the image name
    /// - Returns: An optional UIImage from the cache
    private func returnImageFromCache(imageUrl: String) -> UIImage? {
        guard let cachedImage = ImageCacheManager.returnImagesFromCache(key: imageUrl) else { return nil }
        debugPrint("returning cached image with url: \(imageUrl)")
        return cachedImage
    }
    
//    func savePNGImage(image: UIImage, imageName: String, folderName: String) {
//        // Create folder
//        createFolderIfNeeded(folderName: folderName)
//
//        // Get path for image
//        guard let data = image.pngData(), let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
//
//        // Save image to path
//        do {
//            try data.write(to: url)
//        } catch let error {
//            debugPrint("error saving image: -\(error.localizedDescription)")
//        }
//    }
//
//    func loadImage(with name: String, from folder: String) -> UIImage? {
//        guard let url = getURLForImage(imageName: name, folderName: folder),
//                FileManager.default.fileExists(atPath: url.path) else { return nil }
//        return UIImage(contentsOfFile: url.path)
//    }
//
//    private func createFolderIfNeeded(folderName: String) {
//        guard let url = getUrlForFolder(folderName: folderName) else { return }
//
//        if !FileManager.default.fileExists(atPath: url.path) {
//            do {
//                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
//            } catch let error {
//                debugPrint("Error creating folder. Folder name: \(folderName). \(error.localizedDescription)")
//            }
//        }
//    }
//    private func getUrlForFolder(folderName: String) -> URL? {
//        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
//        return url.appendingPathComponent(folderName)
//    }
//
//    private func getURLForImage(imageName: String, folderName: String) -> URL? {
//        guard let folderURL = getUrlForFolder(folderName: folderName) else { return nil }
//        return folderURL.appendingPathComponent(imageName + ".png")
//    }
}
