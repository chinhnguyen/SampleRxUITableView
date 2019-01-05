//
//  ViewModel.swift
//  SampleRxUITableView
//
//  Created by Chinh Nguyen on 1/5/19.
//  Copyright © 2019 Willbe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias Model = (String, Int)

class ViewModel {
    let disposeBag = DisposeBag()
    let items = BehaviorRelay<[Model]>(value: [])
    let add = PublishSubject<Model>()
    let remove = PublishSubject<Model>()
    let addRandom = PublishSubject<()>()
    
    init() {
        addRandom
            .map { _ in (UUID().uuidString, Int.random(in: 0 ..< 10)) }
            .bind(to: add)
            .disposed(by: disposeBag)
        add.map { newItem in self.items.value + [newItem] }
            .bind(to: items)
            .disposed(by: disposeBag)
        remove.map { removedItem in
            self.items.value.filter { (name, _) -> Bool in
                name != removedItem.0
            }
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}
