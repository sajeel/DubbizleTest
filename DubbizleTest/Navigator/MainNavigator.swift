//
//  MainNavigator.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation
import UIKit
import RxCocoa




@objc class MainNavigator : NSObject, Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var childNavigators = [Navigator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - segues list
    enum Segue {
        case AdsListing
        case AdDetails(adEntity: AdEntity)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .AdsListing:
            //show the Ads listing
            let vm = ListingsViewModel()
            show(target: ListingsViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: sender)
            
        case .AdDetails(adEntity : let adEntity):
//            let detailViewNavigator = DetailViewNavigator(navigationController: self.navigationController)
//            childNavigators.append(detailViewNavigator)
//            detailViewNavigator.parentNavigator = self
            
            
//            let detailViewController : AdsDetailViewController = defaultStoryboard.instantiateViewController(withIdentifier: String(describing: AdsDetailViewController.self)) as! AdsDetailViewController
            //detailViewController.viewModel = vm
            //detailViewController.navigator = self
            let vm  = AdsDetailViewModel(adsEntity: adEntity)
            let adsDetailViewController = AdsDetailViewController.createWith(navigator: self, storyboard: defaultStoryboard, viewModel: vm)

            
            show(target: adsDetailViewController, sender: sender)
        }
    }
    
    
    
    func childDidFinish(_ child: Navigator?) {
        for (index, navigator) in childNavigators.enumerated() {
            if navigator === child {
                childNavigators.remove(at: index)
                break
            }
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController {
            //add controller to navigation stack
            nav.pushViewController(target, animated: true)
        } else {
            //present modally
            sender.present(target, animated: true, completion: nil)
        }
    }
}
