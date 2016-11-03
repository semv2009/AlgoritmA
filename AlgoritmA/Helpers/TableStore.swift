//
//  TableStore.swift
//  AlgoritmA
//
//  Created by Семен Никулин on 29.10.16.
//  Copyright © 2016 niksemv. All rights reserved.
//

import Foundation
import UIKit

class TableStore {
    var row: Int
    var column: Int
    var count: Int
    
    var collectionView: UICollectionView?
    
    var openStore = [TableItemData]()
    var closeStore = [TableItemData]()
    var tempStore = [TableItemData]()
    
    var neighborArray = [IndexPath(item: -1, section: -1), IndexPath(item: 0, section: -1), IndexPath(item: 1, section: -1), IndexPath(item: -1, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: -1, section: 1), IndexPath(item: 0, section: 1), IndexPath(item: 1, section: 1)]
    
    var start = TableItemData(weight: 10, color: UIColor.white, index: IndexPath(row: 0, section: 0))
    var end = TableItemData(weight: 10, color: UIColor.white, index: IndexPath(row: 0, section: 0))
    
    var table: [[TableItemData]]
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        self.count = row * column
        table = Array(repeating: Array(repeating: TableItemData(weight: 10, color: UIColor.white, index: IndexPath(row: 0, section: 0)), count: column), count: row)
        fillTable()
    }
    
    func fillTable() {
        for i in 0...row - 1 {
            for j in 0...column - 1 {
                table[i][j] = TableItemData(weight: 10, color: UIColor.black, index: IndexPath(row: j, section: i))
            }
        }
        
        table[1][3].color = UIColor.red
        table[1][3].weight = -1
        
        table[2][3].color = UIColor.red
        table[2][3].weight = -1
        
        table[3][3].color = UIColor.red
        table[3][3].weight = -1
        
        start = table[2][1]
        table[2][1].color = UIColor.cyan
        
        end = table[2][4]
        table[2][4].color = UIColor.orange
        
    }
    
    func findPath() {
        DispatchQueue.global().async {
            self.add(toClose: IndexPath(row: 1, section: 2))
            var check = true
            print("start")
            while check {
                print("hello")
                self.findNeighborCell()
                DispatchQueue.main.async {
                    
            
                        self.collectionView?.reloadItems(at: self.openStore.map({$0.index}))
                    

                    
                }
                
                sleep(1)

                //                UIView.animate(withDuration: 2) {
                //                    self.collectionView?.reloadItems(at: self.openStore.map({$0.index}))
                //                }
                if let min = self.findMinCost() {
                    print(min.index)
                    min.color = UIColor.cyan
                    self.add(toClose: min.index)
                    self.remove(fromOpen: min)
                    sleep(1)
                    DispatchQueue.main.async {
                    
                            self.collectionView?.reloadItems(at: [min.index])
                        
                    }
                    
                    if min == self.end {
                        check = false
                    }
                }
                
                
            }
            var endP = self.closeStore.last
            while endP != nil {
                sleep(1)
                
                endP?.color = UIColor.blue
                if let endP = endP {
                    DispatchQueue.main.async {
                        self.collectionView?.reloadItems(at: [endP.index])
                    }
                    
                }
                endP = endP?.parent
            }
//                    UIView.animate(withDuration: 10) {
//                        self.collectionView?.reloadItems(at: self.closeStore.map({$0.index}))
//                    }

        }
        

    }
    
    func add(toOpen index: IndexPath) {
        if let item = itemData(indexPath: index) {
            openStore.append(item)
        }
    }
    
    func add(toClose index: IndexPath) {
        if let item = itemData(indexPath: index) {
            closeStore.append(item)
        }
    }
    
    func add(toTemp index: IndexPath) {
        if let item = itemData(indexPath: index) {
            tempStore.append(item)
        }
    }
    
    func remove(fromOpen item: TableItemData) {
        if let index = openStore.index(of: item) {
            openStore.remove(at: index)
        }
    }
    
    func inOpen(newItem: TableItemData) -> Bool {
        return openStore.contains(where: { $0 == newItem})
    }
    
    func inClose(newItem: TableItemData) -> Bool {
         return closeStore.contains(where: { $0 == newItem})
    }
    
    func findNeighborCell() {
        let item = closeStore[closeStore.count - 1]
        let row = item.index.section
        let column = item.index.row
        for neighbor in neighborArray {
            let newIndex = IndexPath(row: neighbor.row + column, section: neighbor.section + row)
            if let newItem = itemData(indexPath: newIndex) {
                if newItem.weight > 0  && !inClose(newItem: newItem) {
                    print(newItem.index)
                    newItem.color = UIColor.green
                    newItem.isValue = true
                    newItem.configure(prevG: item.G, endIndex: end.index)
                    if newItem.parent == nil {
                       newItem.parent = item
                    }
                    add(toTemp: newIndex)
                }
            }
        }
        
        for newItem in tempStore {
            if newItem.G < item.G + 10 {
                newItem.parent = item
                newItem.configure(prevG: item.G, endIndex: end.index)
            }
            if !inOpen(newItem: newItem) {
                 add(toOpen: newItem.index)
            }
        }
        tempStore.removeAll()
    }
    
    func findMinCost() -> TableItemData? {
        if openStore.count > 0 {
            var min = openStore[0]
            for item in openStore {
                if item.F < min.F {
                    min = item
                }
            }
            return min
        }
        return nil
    }
    
    var numberOfSections: Int {
        return row
    }
    
    var numberOfItemsInSection: Int {
        return column
    }
    
    func itemData(indexPath: IndexPath) -> TableItemData? {
        if indexPath.section > -1 && indexPath.section < row
            && indexPath.row > -1 && indexPath.row < column {
            return table[indexPath.section][indexPath.row]
        }
        return nil
    }
    
}
