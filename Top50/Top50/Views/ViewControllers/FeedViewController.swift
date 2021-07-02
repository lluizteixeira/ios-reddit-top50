//
//  FeedViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var aiLoader: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.feed.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = self.viewModel.feed[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? FeedCell        
        else { return UITableViewCell.init() }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let postViewController = PostViewController.instantiate(storyboard: .main) as? PostViewController {
            
        }
    }
}
