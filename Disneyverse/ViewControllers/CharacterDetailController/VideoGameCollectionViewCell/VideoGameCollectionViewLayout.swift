//
//  CustomCollectionViewLayout.swift
//  Disneyverse
//
//  Created by Faizan Memon on 12/05/23.
//


import UIKit

protocol CustomCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, offsetForItemAtIndexPath indexPath: IndexPath) -> (CGFloat, CGFloat)
    func getContentSize(_ collectionView: UICollectionView) -> CGSize
}

class CustomCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: CustomCollectionViewLayoutDelegate?

    fileprivate var attributesCache = [UICollectionViewLayoutAttributes]()

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        return delegate?.getContentSize(collectionView) ?? .zero
    }

    override func prepare() {
        guard let collectionView = collectionView, let delegate = delegate, collectionView.numberOfSections > 0 else { attributesCache.removeAll(); return }

        attributesCache.removeAll()
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellSize = delegate.collectionView(collectionView, sizeForItemAtIndexPath: indexPath)
            let offset = delegate.collectionView(collectionView, offsetForItemAtIndexPath: indexPath)
            let frame = CGRect(x: offset.0, y: offset.1, width: cellSize.width, height: cellSize.height)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            attributesCache.append(attributes)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
}
