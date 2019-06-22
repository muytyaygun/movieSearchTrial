//
//  TableViewNibCell.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class TableViewNibCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
    }
    
    class func instance<T : UITableViewCell>() -> T {
        let nibName = String.init(describing: self)
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
    }
    
    class func reuseIdentifier() -> String {
        let className = String.init(describing: self)
        return className
    }
}
