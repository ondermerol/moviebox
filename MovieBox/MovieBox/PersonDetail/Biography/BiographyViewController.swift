//
//  BiographyViewController.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit


class BiographyViewController: BaseViewControlller {

    // MARK: Properties
    
    var router: (NSObjectProtocol & BiographyViewRoutingLogic & BiographyViewDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let biographyText = router?.dataStore?.biographyText, let name = router?.dataStore?.name {
            setupLabel(biographyText, name)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = BiographyViewInteractor()
        //let presenter = BiographyViewPresenter()
        let router = BiographyViewRouter()
        //viewController.interactor = interactor
        viewController.router = router
        //interactor.presenter = presenter
        //presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLabel(_ biographyText: String, _ name: String) {
          
        let labelName = UILabel()
        labelName.font = FontUtility.titleFont()
        labelName.textColor = ColorUtility.titleColor()
        labelName.numberOfLines = 0
        labelName.text = name
        
        view.addSubview(labelName)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        labelName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let closeLabel = UILabel()
        closeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        closeLabel.textColor = ColorUtility.appTopColor()
        closeLabel.text = "X"
        closeLabel.textAlignment = .center
        view.addSubview(closeLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        closeLabel.isUserInteractionEnabled = true
        closeLabel.addGestureRecognizer(tap)
        
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        closeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        closeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let labelBiography = UILabel()
        labelBiography.font = FontUtility.descriptionFont()
        labelBiography.textColor = ColorUtility.decriptionColor()
        labelBiography.numberOfLines = 0
        labelBiography.text = biographyText
        
        view.addSubview(labelBiography)
        
        labelBiography.translatesAutoresizingMaskIntoConstraints = false
        labelBiography.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20).isActive = true
        labelBiography.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelBiography.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelBiography.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func closeAction(sender: UIBarButtonItem) {
        router?.routeBack()
    }
}
