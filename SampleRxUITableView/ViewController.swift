//
//  ViewController.swift
//  SampleRxUITableView
//
//  Created by Chinh Nguyen on 1/5/19.
//  Copyright © 2019 Willbe. All rights reserved.
//

import UIKit
import Material
import RxSwift
import SnapKit

class ViewController: Material.ViewController {
    let disposeBag = DisposeBag()
    let vm = ViewModel()
    
    let tableView = UITableView()
    let addButton = FABButton(image: Icon.cm.add, tintColor: .white)

    override func prepare() {
        super.prepare()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addButton.pulseColor = .white
        addButton.backgroundColor = Color.red.base
        view.layout(addButton)
            .width(48)
            .height(48)
            .bottomRight(bottom: 16, right: 16)
        addButton.rx.tap
            .bind(to: vm.addRandom)
            .disposed(by: disposeBag)
        
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        vm.items
            .bind(to: tableView.rx.items) { (tableView, row, model) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
                cell.model = model
                cell.disposeBag = DisposeBag()
                cell.removeButton.rx.tap
                    .map { _ in model }
                    .bind(to: self.vm.remove)
                    .disposed(by: cell.disposeBag!)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

