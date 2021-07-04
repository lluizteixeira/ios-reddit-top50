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
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: PROPERTIES
    let refreshControl = UIRefreshControl()
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    weak var delegate: FeedViewControllerDelegate?

    //MARK: VIEW LOGIC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
        
        getFeed()

    }

    @objc
    func refresh(_ sender: AnyObject) {
        getFeed()
    }
    
    func getFeed() {
        
        refreshControl.beginRefreshing()
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getFeed { (error) in
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.refreshControl.endRefreshing()
                    
                    if error != nil {
                        print(error)
                    }
                }
            }
        }
        
    }
}

//MARK: IBACTIONS
extension FeedViewController {
    
    @IBAction func doRemovePost(_ sender: Any) {
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableview)
        if let indexPath = self.tableview.indexPathForRow(at: buttonPosition) {
            self.viewModel.deletePost(index: indexPath.row) {
                self.tableview.beginUpdates()
                self.tableview.deleteRows(at: [indexPath], with: .left)
                self.tableview.endUpdates()
            }
        }
    }
    
}

//MARK: TABLEVIEW DELEGATES
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
