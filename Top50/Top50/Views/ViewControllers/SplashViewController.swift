//
//  SplashViewController.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 04/07/21.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateLogo {
            if let mainController = UISplitViewController.instantiate("splitFeedController", storyboard: .main) as? UISplitViewController {                
                self.toMainControllerAsRoot(mainController)
            }
        }
    }
    
    func animateLogo(onCompletion: @escaping () -> Void) {        
        UIView.animate(withDuration: 0.3,
            animations: {
                self.logoImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.logoImageView.alpha = 0.0
            },
            completion: { _ in
                onCompletion()
            })
    }
    
    func toMainControllerAsRoot (_ controller: UISplitViewController) {
        let window = UIApplication.shared.windows[0]
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
        }, completion: { _ in
            
        })
    }
}
