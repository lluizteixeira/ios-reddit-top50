//
//  FeedViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import UIKit


protocol FeedViewControllerDelegate: class {
  func selectPost(_ post: Post)
  func dismiss()
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
        
        ///sets tableview delegates
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.estimatedRowHeight = 212.0
        self.tableview.rowHeight = UITableView.automaticDimension
        
        ///adds pull to refresh to tableview
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading Feed")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
        
        ///reloads the post feed
        getFeed()
    }

    /// pull request selector
    @objc
    func refresh(_ sender: AnyObject) {
        self.viewModel.after = ""
        getFeed()
    }
    
    /// getFeed - get feed data from viewModel
    ///
    /// ```
    /// getFeed()
    /// ```
    func getFeed() {
        
        ///checks if user is reloading feed or next page to show pull to request
        if self.viewModel.after == "" {
            refreshControl.beginRefreshing()
        }
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getFeed { [weak self] (error) in
                
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.refreshControl.endRefreshing()
                    self.tableview.removeFooterLoader()
                    
                    if error != nil {
                        self.alert(title: "Error", error: "Error when loading the Top 50 feed. Try again later.")
                    }
                }
            }
        }
    }
    
    func removePostAtIndex(_ indexPath: IndexPath) {
        self.viewModel.deletePostAt(index: indexPath.row)
        self.tableview.beginUpdates()
        self.tableview.deleteRows(at: [indexPath], with: .left)
        self.tableview.endUpdates()
    }
}

//MARK: IBACTIONS
extension FeedViewController {
    
    /// doRemovePost - remove one post from the feed
    @IBAction func doRemovePost(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableview)
        if let indexPath = self.tableview.indexPathForRow(at: buttonPosition) {
            self.removePostAtIndex(indexPath)
        }
    }
    
    /// doRemoveAllPost - remove all posts from the feed
    @IBAction func doRemoveAllPost(_ sender: Any) {
        self.viewModel.deleteAllPosts()
        self.tableview.beginUpdates()
        self.tableview.reloadSections(IndexSet(integer: 0), with: .left)
        self.tableview.endUpdates()
        
        if let delegate = self.delegate {
            delegate.dismiss()
        }
    }
    
}

//MARK: TABLEVIEW DELEGATES
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.feed.count > 0 {
            return self.viewModel.feed.count
        } else {
            if self.viewModel.hasLoaded {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.viewModel.feed.count > 0 {
            let postContainer = self.viewModel.feed[indexPath.row]
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifer, for: indexPath) as? FeedCell
            else { return UITableViewCell.init() }
        
            cell.post = postContainer.data
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.viewModel.feed.count > 0 {
            let postContainer = self.viewModel.feed[indexPath.row]
        
            cell.backgroundColor = UIColor.init(named: "newFeedCellBg")
        
            if postContainer.data?.isNew == false {
                cell.backgroundColor = UIColor.init(named: "feedCellBg")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.viewModel.feed.count > 0 {
            tableview.deselectRow(at: indexPath, animated: true)
        
            let postContainer = self.viewModel.feed[indexPath.row]
        
            /// checks if delegate has been set to detail view (PostViewController), otherwise sets it now
            if self.delegate == nil {
                if let navigationController = UINavigationController.instantiate("navDetail", storyboard: .main) as? UINavigationController {
            
                    if let postViewController = navigationController.viewControllers[0] as? PostViewController {
                        delegate = postViewController
                    }
                
                    self.splitViewController?.setViewController(navigationController, for: .secondary)
                }
            }
        
            /// having delegates and a valid post set it on PostViewController
            if let delegate = self.delegate as? PostViewController, let post = postContainer.data {
            
                post.isNew = false
            
                delegate.selectPost(post)
                self.splitViewController?
                  .showDetailViewController(delegate, sender: nil)
            }
        
            self.tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.removePostAtIndex(indexPath)
        }
    }
}

// MARK: UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    
    /// scrollview delegate for pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableview.contentOffset.y + tableview.frame.size.height >= tableview.contentSize.height-350 {
            if self.viewModel.feed.count > 0 {
                self.tableview.addFooterLoader()
                getFeed()
            }
        }
    }
}
