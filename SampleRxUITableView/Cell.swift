//
//  Cell.swift
//  SampleRxUITableView
//
//  Created by Chinh Nguyen on 1/5/19.
//  Copyright © 2019 Willbe. All rights reserved.
//

import Foundation
import Material
import RxSwift
import SnapKit

class Cell: Material.TableViewCell {
    var disposeBag: DisposeBag?
    let nameLabel = UILabel(frame: .zero)
    let valueLabel = UILabel(frame: .zero)
    let removeButton = FlatButton(title: "REMOVE")
    
    var model: Model? = nil {
        didSet {
            guard let (name, value) = model else {
                nameLabel.text = ""
                valueLabel.text = ""
                return
            }
            nameLabel.text = name
            valueLabel.text = "\(value)"
        }
    }
    
    override func prepare() {
        super.prepare()
        let textWrapper = UIStackView()
        textWrapper.axis = .vertical
        textWrapper.distribution = .fill
        textWrapper.alignment = .fill
        textWrapper.spacing = 8
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        textWrapper.addArrangedSubview(nameLabel)
        textWrapper.addArrangedSubview(valueLabel)
        
        let wrapper = UIStackView()
        wrapper.axis = .horizontal
        wrapper.distribution = .fill
        wrapper.alignment = .fill
        wrapper.spacing = 8
        addSubview(wrapper)
        wrapper.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        wrapper.addArrangedSubview(textWrapper)
        wrapper.addArrangedSubview(removeButton)
    }
}
