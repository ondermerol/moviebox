//
//  LoadingViewUtility.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit

class LoadingViewUtility {
    private var loadingView: UIView?
    
    private static let shared: LoadingViewUtility = {
        let shared = LoadingViewUtility()
        return shared
    }()
    
    static func showLoadingView(onView: UIView? = nil) {
        let indicatorView = UIView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
        indicatorView.alpha = 0.3
        indicatorView.backgroundColor = .black
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.center = CGPoint(x: indicatorView.center.x, y: indicatorView.center.y - 100)
        indicatorView.addSubview(indicator)
        indicator.startAnimating()
        
        shared.loadingView = indicatorView
        indicator.isAccessibilityElement = true
        indicator.accessibilityLabel = "loading"
        
        if let view = onView {
            view.addSubview(indicatorView)
            indicatorView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            indicatorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else if let window = UIApplication.shared.keyWindow {
            window.addSubview(indicatorView)
            indicatorView.topAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            indicatorView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            indicatorView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            indicatorView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            indicatorView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        }
    }
    
    static func hideLoadingView() {
        shared.loadingView?.removeFromSuperview()
        shared.loadingView = nil
    }
    
    
    static func isShowingLoadingView() -> Bool {
        return shared.loadingView != nil
    }
}
