//
//  ReusableCell.swift
//  UserTasks
//
//  Created by rtoukrichte on 10/12/2021.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String.init(describing: self)
    }
}

protocol ConfigurableCell: ReusableCell, NibLoadable {
    associatedtype T
    func configureCell(with item: T)
}
