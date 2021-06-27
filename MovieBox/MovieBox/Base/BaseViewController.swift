//
//  BaseViewController.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit

class BaseViewControlller: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func getTotalTopBarHeight() -> CGFloat {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? CGFloat(0)
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        return navBarHeight + statusBarHeight
    }
}
