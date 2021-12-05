//
//  UIApplication+.swift
//  Wain
//
//  Created by Sajjeel Khilji on 7/28/19.
//  Copyright © 2019 QMIC. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxAppState
extension RxSwift.Reactive where Base: UIApplication {
    
    static var isAppInForeGround: Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(true)
           
            let appState = UIApplication.shared.rx.appState
                .map({ (appState) -> Bool in
                    appState == .active
                })
                .distinctUntilChanged()
                .subscribe(onNext: { (isAppStateInForeGround) in
                    observer.onNext(isAppStateInForeGround)
                     print("onNext")
                }, onError: { (error) in
                    observer.onError(error)
                     print("error")
                }, onCompleted: {
                    print("onCompleted")
                }, onDisposed: {
                    print("onDisposed")
                })
            
            return Disposables.create {
                appState.dispose()
            }
        }
    }
    
}



/*
 
 
 
 return Observable.of(
 UIApplication.shared.rx.applicationDidBecomeActive,
 UIApplication.shared.rx.applicationDidEnterBackground
 )
 .merge()
 //.distinctUntilChanged()
 .map { appState in
 return appState == .active
 }
 }
 
 */
