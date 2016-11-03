//
//  CustomUICollectionViewFlowLayout.swift
//  AlgoritmA
//
//  Created by Семен Никулин on 26.10.16.
//  Copyright © 2016 niksemv. All rights reserved.
//

import UIKit

class CustomUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let numberOfColumns: CGFloat
    
    init(numberOfColumns: CGFloat) {
        self.numberOfColumns = numberOfColumns
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        
        get {
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
