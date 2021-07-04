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
        
        ///adds pull to refresh to tableview
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading Feed")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl)
        
        ///reloads the post feed
        getFeed()
    }

    @objc
    func refresh(_ sender: AnyObject) {
        self.viewModel.after = ""
        getFeed()
    }
    
    func getFeed() {
        
        if self.viewModel.after == "" {
            refreshControl.beginRefreshing()
        }
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getFeed { (error) in
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.refreshControl.endRefreshing()
                    
                    if error != nil {
                        self.alert(title: "Error", error: "Error when loading the Top 50 feed. Try again later.")
                    }
                }
            }
        }
    }
    
    func removePostAtIndex(_ indexPath: IndexPath) {
        self.viewModel.deletePost(index: indexPath.row)
        self.tableview.beginUpdates()
        self.tableview.deleteRows(at: [indexPath], with: .left)
        self.tableview.endUpdates()
    }
}

//MARK: IBACTIONS
extension FeedViewController {
    
    @IBAction func doRemovePost(_ sender: Any) {
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableview)
        if let indexPath = self.tableview.indexPathForRow(at: buttonPosition) {
            self.removePostAtIndex(indexPath)
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let postContainer = self.viewModel.feed[indexPath.row]
        
        cell.backgroundColor = .colorFromHex(hex: "#EAEAEA")
        
        if postContainer.data?.isNew == false {
            cell.backgroundColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableview.deselectRow(at: indexPath, animated: true)
        
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
            
            post.isNew = false
            
            delegate.selectPost(post)
            self.splitViewController?
                  .showDetailViewController(delegate, sender: nil)
        }
        
        self.tableview.reloadData()
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableview.contentOffset.y + tableview.frame.size.height >= tableview.contentSize.height-350 {
            getFeed()
        }
    }
}
