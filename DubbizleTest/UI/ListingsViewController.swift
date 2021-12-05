//
//  ViewController.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import UIKit
import RxSwift
import Then
import RxCocoa
import MBProgressHUD

typealias TableViewOutput = UITableViewDataSource & UITableViewDelegate



class ListingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    let refreshControl = UIRefreshControl()
    
    private let bag = DisposeBag()
    fileprivate var viewModel: ListingsViewModel!
    fileprivate var navigator: MainNavigator!

    static func createWith(navigator: MainNavigator, storyboard: UIStoryboard, viewModel: ListingsViewModel) -> ListingsViewController {
        return storyboard.instantiateViewController(ofType: ListingsViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ads"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.assignProtocols(to: self)
        bindUI()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //tableView.addSubview(refreshControl)
        MBProgressHUD.showAdded(to: self.view, animated: true)
     
        
    }
    
    func bindUI() {
        //show tweets in table view
        viewModel.ads.asDriver()
            .drive(onNext: { [weak self] _ in
                
                self?.tableView.reloadData()
            })
            .disposed(by: bag)
        
        //show message when no data available
        viewModel.ads.asDriver()
            .map { $0 != nil }
            .drive(onNext: { [weak self] _ in
               // self?.refreshControl.endRefreshing()
                if self?.viewModel.adsCellViewModel.value?.count ?? 0 > 0 , let view = self?.view{
                    MBProgressHUD.hide(for: view, animated: true)
                }
                self?.messageView.isHidden = true
            })
            //.drive(messageView.rx.isHidden)
            .disposed(by: bag)
    
        
        
        
    }
}

extension ListingsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfSections)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.adsCellViewModel.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueCell(ofType: AdCellView.self).then { cell in
            cell.update(with: viewModel.adsCellViewModel.value![indexPath.row])
        }
    }
}

extension ListingsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let adsCellViewModel = viewModel.adsCellViewModel.value?[indexPath.row] else { return }
        navigator.show(segue: .AdDetails(adEntity: adsCellViewModel.adEntity), sender: self)
    }
}




