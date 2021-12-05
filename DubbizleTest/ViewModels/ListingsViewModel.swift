//
//  ListingsViewModel.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability
import RxAppState

class ListingsViewModel {
    private let bag = DisposeBag()
    let apiType: ListingsAPIProtocol.Type
    
    // MARK: - Input
    var paused = BehaviorRelay<Bool>(value: false)
    // MARK: - Output
    let ads = BehaviorRelay<[AdEntity]?>(value: nil)
    let adsCellViewModel = BehaviorRelay<[AdCellViewModel]?>(value: nil)
    
    
    // MARK: - Init
    init(
        apiType: ListingsAPIProtocol.Type = ListingsAPI.self) {
            self.apiType = apiType
            bindOutput()
        }
    
    func bindOutput() {
        let reachableRepeatedTimerInForeGround = Observable.combineLatest(
            Reachability.rx.reachable,
            paused.asObservable(),
            //UIApplication.rx.isAppInForeGround,
            resultSelector: { reachable, paused  in//, isInForeGround  in
                return  ( (reachable && !paused  )) ? true : nil
            })
            .filter { $0 != nil }
            .map { $0! }
        
        let output = reachableRepeatedTimerInForeGround
            .filter{ $0 }
            .flatMapLatest { [self] isCallable in
                apiType.getListing()
            }
            .map({ adsListing in
                return adsListing.results
            })
        
        output
            
            .share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
            .bind(to: ads)
            .disposed(by: bag)
        
        output
            .map{
                $0.map { AdCellViewModel.init(adEntity: $0) }
            }.bind(to: adsCellViewModel)
            .disposed(by: bag)
        
    }
}
