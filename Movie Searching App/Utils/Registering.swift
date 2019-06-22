//
//  Registering.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func ms_registerClass(cellClass: AnyClass) {
        let className = String.init(describing: cellClass)
        
        if let _ = Bundle.main.path(forResource: className, ofType: "nib") {
            self.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
        else {
            self.register(cellClass, forCellReuseIdentifier: className)
        }
    }
    
    func registerCustomTableViewNibCells(classNames: [AnyClass]) {
        if classNames.count > 0 {
            for className in classNames {
                self.ms_registerClass(cellClass: className)
            }
        }
    }
}
