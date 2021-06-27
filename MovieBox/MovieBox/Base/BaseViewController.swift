//
//  BaseViewController.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

class BaseViewControlller: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customizeNavigationBar()
    }
    
    func getTotalTopBarHeight() -> CGFloat {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? CGFloat(0)
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        return navBarHeight + statusBarHeight
    }
    
    private func customizeNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = ColorUtility.appTopColor()
        self.navigationController?.navigationBar.tintColor = .white
        
        if let font = UIFont(name: "HelveticaNeue-Medium", size: 20.0) {
            self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                             NSAttributedString.Key.font: font]
        }
    }
}
