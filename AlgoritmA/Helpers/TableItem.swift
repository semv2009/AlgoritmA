//
//  TableItem.swift
//  AlgoritmA
//
//  Created by Семен Никулин on 29.10.16.
//  Copyright © 2016 niksemv. All rights reserved.
//

import Foundation
import UIKit

struct TableItem {
    var data: TableItemData
}

class TableItemData: Equatable {
    var weight: Int
    var isValue = false
    var color: UIColor
    
    var parent: TableItemData?
    
    var G = 0
    var H = 0
    var F = 0
    
    var index: IndexPath {
        didSet(newValue) {
            print("Did set \(newValue)")
        }
    }
    
    static func ==(left: TableItemData, right: TableItemData) -> Bool {
        if left.index == right.index {
            return true
        }
        return false
    }
    
    func configureG(to prevG: Int) {
        self.G = self.weight + prevG
    }
    
    func configureH(to endIndex: IndexPath) {
        self.H = (abs(endIndex.section - index.section) + abs(endIndex.row - index.row)) * 10
    }
    
    func configureF() {
        F = G + H
    }
    
    func configure(prevG : Int, endIndex: IndexPath) {
        configureG(to: prevG)
        configureH(to: endIndex)
        configureF()
    }
    
    init(weight: Int, color: UIColor, index: IndexPath) {
        self.weight = weight
        self.color = color
        self.index = index
    }
}
