//
//  UIViewExtensions.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit


extension UIView {
    
    var top: CGFloat {
        self.frame.origin.y
    }
    
    var bottom: CGFloat {
        self.frame.size.height + top
    }
    
    var left: CGFloat {
        self.frame.origin.x
    }
    
    var width: CGFloat {
        self.frame.size.width
    }
    
    var height: CGFloat {
        self.frame.size.height
    }
    
    var right: CGFloat {
        left + width
    }
    
    func addMultipleSub(views: [UIView] ) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
