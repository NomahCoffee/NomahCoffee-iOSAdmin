//
//  ProductListConstants.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/26/21.
//

import UIKit

struct ProductListConstants {
    
    static var collectionViewInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
    }
    
    static var cellSize: CGSize {
        let columnCount: CGFloat = 2
        // Set the space between the colums to be be half of the outer margins (24+12+24)
        let totalInset = collectionViewInsets.left * 2 + ((columnCount - 1) * (collectionViewInsets.left / 2))
        let storyWidth = (UIScreen.main.bounds.width - totalInset) / columnCount
        return CGSize(width: storyWidth, height: 200)
    }
    
    static let imageViewCornerRadius: CGFloat = 4
    static let imageViewBorderWidth: CGFloat = 1
    static let labelStackSpacing: CGFloat = 4
    
}
