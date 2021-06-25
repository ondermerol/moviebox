//
//  DashboardViewRouter.swift
//  MovieBox
//
//  Created by Onder on 25.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol DashboardViewRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DashboardViewDataPassing
{
  var dataStore: DashboardViewDataStore? { get }
}

class DashboardViewRouter: NSObject, DashboardViewRoutingLogic, DashboardViewDataPassing
{
  weak var viewController: DashboardViewViewController?
  var dataStore: DashboardViewDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: DashboardViewViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: DashboardViewDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
