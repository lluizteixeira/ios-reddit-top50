//
//  SplitViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 05/07/21.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.maximumPrimaryColumnWidth = UIScreen.main.bounds.width/3;
        self.minimumPrimaryColumnWidth = UIScreen.main.bounds.width/3;
    }

}
