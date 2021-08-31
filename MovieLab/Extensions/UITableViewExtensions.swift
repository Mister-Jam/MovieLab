//
//  UITableViewExtensions.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit

extension UITableView {
    func registerTableViewCell(cell: UITableViewCell.Type) {
        let identifier = String(describing: cell)
        self.register(cell, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(with cell: UITableViewCell.Type, indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: cell)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
