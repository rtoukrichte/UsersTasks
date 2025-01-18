//
//  NibLoadable.swift
//  UserTasks
//
//  Created by rtoukrichte on 10/12/2021.
//

import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String.init(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: Bundle(for: self))
    }
}
