//
//  DetailViewController.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var feed : Feed?
    let imageDownloadManager = ImageDownloadManager()
    
    let openItunesButton : UIButton = {
        let t = UIButton()
        t.backgroundColor = .blue
        t.setTitle("Open in iTunes", for: .normal)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let imageView : UIImageView = {
        let t = UIImageView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    
    let artistName : UILabel = {
        let t = UILabel()
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let album : UILabel = {
        let t = UILabel()
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let genre : UILabel = {
        let t = UILabel()
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let releaseDate : UILabel = {
        let t = UILabel()
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let copyrightInfo : UILabel = {
        let t = UILabel()
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let margins = view.layoutMarginsGuide
        self.view.addSubview(openItunesButton)
        openItunesButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        openItunesButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        openItunesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        openItunesButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        openItunesButton.addTarget(self, action: #selector(openInItunes), for: .touchUpInside)
        
        guard let feed = feed else {
            return
        }
        imageView.image = imageDownloadManager.getCachedImage(urlStr: feed.artworkUrl100)
        self.view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        
        self.view.addSubview(artistName)
        artistName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        artistName.setContentCompressionResistancePriority(.required, for: .vertical)
        artistName.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        artistName.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        artistName.text = "Artist : \(feed.artistName ?? "")"
        
        self.view.addSubview(album)
        album.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10).isActive = true
        album.setContentCompressionResistancePriority(.required, for: .vertical)
        album.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        album.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        album.text = "Album : \(feed.name ?? "")"
        
        self.view.addSubview(releaseDate)
        releaseDate.topAnchor.constraint(equalTo: album.bottomAnchor, constant: 10).isActive = true
        releaseDate.setContentCompressionResistancePriority(.required, for: .vertical)
        releaseDate.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        releaseDate.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        releaseDate.text = "Release Date : \(feed.releaseDate ?? "")"
        
        self.view.addSubview(genre)
        genre.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 10).isActive = true
        genre.setContentCompressionResistancePriority(.required, for: .vertical)
        genre.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        genre.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        genre.text = "Genres : \(feed.genres)"
        
        self.view.addSubview(copyrightInfo)
        copyrightInfo.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 10).isActive = true
        copyrightInfo.setContentCompressionResistancePriority(.required, for: .vertical)
        copyrightInfo.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        copyrightInfo.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        copyrightInfo.text = "Copyright Info : \(feed.copyright ?? "")"
        
    }
    
    @objc func openInItunes() {
        guard let urlStr = feed?.url, let url = URL(string: urlStr) else {
            return
        }
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
