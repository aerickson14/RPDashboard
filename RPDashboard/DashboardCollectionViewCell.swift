//
//  DashboardCollectionViewCell.swift
//  RPDashboard
//
//  Created by Andrew Erickson on 2015-10-18.
//  Copyright © 2015 Andrew Erickson. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var innerBackground: UIView!
    @IBOutlet weak var title: UILabel!
    
    func highlight() {
        title.font = title.font.bold()
    }
    
    func unhighlight() {
        title.font = title.font.normal()
    }
}

extension UIFont {
    func bold() -> UIFont {
        let descriptor = self.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func normal() -> UIFont {
        let descriptor = self.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitUIOptimized)
        return UIFont(descriptor: descriptor, size: 0)
    }
}
