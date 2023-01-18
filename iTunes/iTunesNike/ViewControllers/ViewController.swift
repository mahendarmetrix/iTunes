//
//  ViewController.swift
//  iTunesNike
//
//  Created by Mahendar ramidi on 5/7/19.
//  Copyright © 2019 Mahendar ramidi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let iTunesSearchService = ITunesSearchService()
    let imageDownloadManager = ImageDownloadManager()
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    var feeds = [Feed]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        iTunesSearchService.getSearchResults {[weak self] (feeds, error) in
            guard let strongSelf = self else { return }
            if error.count > 0 {
                strongSelf.showAlert(title: error)
            }
            if let feeds = feeds {
                strongSelf.feeds = feeds
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func showAlert(title: String? = "", message: String? = "") {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = feeds[indexPath.row].name ?? ""
        cell?.detailTextLabel?.text = "Artist : \(feeds[indexPath.row].artistName ?? "")"
        if let image = imageDownloadManager.getCachedImage(urlStr: feeds[indexPath.row].artworkUrl100){
            cell?.imageView?.image = image
        }
        else{
            imageDownloadManager.getImageData(urlStr: feeds[indexPath.row].artworkUrl100) {[weak self] (img) in
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = feeds[indexPath.row]
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.feed = feed
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

