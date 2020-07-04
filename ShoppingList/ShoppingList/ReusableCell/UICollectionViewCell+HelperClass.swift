//
//  UICollectionViewCell+HelperClass.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/5/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T:UICollectionViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T:UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T:UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

}

//MARK:- Helper CollectionViww Subclass

class DynamicCollectionView : UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

//MARK:- Dynamic Flow Layout
class DynamicCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var dynamicCellAttributes = [UICollectionViewLayoutAttributes]()
    let lEdgeInset: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let cellAttributesArray = super.layoutAttributesForElements(in: rect)
        if(cellAttributesArray != nil && cellAttributesArray!.count > 1) {
            for i in 1..<(cellAttributesArray!.count) {
                let beforeLayoutAttributes: UICollectionViewLayoutAttributes = cellAttributesArray![i - 1]
                let nowLayoutAttributes: UICollectionViewLayoutAttributes = cellAttributesArray![i]
                let maximumSpacing: CGFloat = 8
                let prevCellMaxX: CGFloat = beforeLayoutAttributes.frame.maxX
                let sectionWidth = self.collectionViewContentSize.width - lEdgeInset
                let currentCellExpectedMaxX = prevCellMaxX + maximumSpacing + (nowLayoutAttributes.frame.size.width )
                if currentCellExpectedMaxX < sectionWidth {
                    var frame: CGRect? = nowLayoutAttributes.frame
                    frame?.origin.x = prevCellMaxX + maximumSpacing
                    frame?.origin.y = beforeLayoutAttributes.frame.origin.y
                    nowLayoutAttributes.frame = frame ?? CGRect.zero
                } else {
                    nowLayoutAttributes.frame.origin.x = lEdgeInset
                    if (beforeLayoutAttributes.frame.origin.x != 0) {
                        nowLayoutAttributes.frame.origin.y = beforeLayoutAttributes.frame.origin.y + beforeLayoutAttributes.frame.size.height + 08
                    }
                }
            }
        }
        return cellAttributesArray
    }
}
