//
//  FeedViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import UIKit


protocol FeedViewControllerDelegate: class {
  func selectPost(_ post: Post)
}

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var aiLoader: UIActivityIndicatorView!
    
    weak var delegate: FeedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        getFeed()

    }
    
    func getFeed() {
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getFeed {
                DispatchQueue.main.async {
                    self.aiLoader.stopAnimating()
                    self.tableview.reloadData()
                }
            } failure: { (error) in
                DispatchQueue.main.async {
                    
                }
            }
        }
        
    }
}

extension FeedViewController {
    
    @IBAction func doRemovePost(_ sender: Any) {
        
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
        
        let postContainer = self.viewModel.feed[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifer, for: indexPath) as? FeedCell        
        else { return UITableViewCell.init() }
        
        cell.post = postContainer.data
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let postContainer = self.viewModel.feed[indexPath.row]
        
        if self.delegate == nil {
            if let navigationController = UINavigationController.instantiate("navDetail", storyboard: .main) as? UINavigationController {
            
                if let postViewController = navigationController.viewControllers[0] as? PostViewController {
                    delegate = postViewController
                }
                
                self.splitViewController?.setViewController(navigationController, for: .secondary)
            }
        }
        
        if let delegate = self.delegate as? PostViewController, let post = postContainer.data {
            delegate.selectPost(post)
            self.splitViewController?
                  .showDetailViewController(delegate, sender: nil)
        }
    }
}
