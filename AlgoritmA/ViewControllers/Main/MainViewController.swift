//
//  MaintViewController.swift
//  AlgoritmA
//
//  Created by Семен Никулин on 26.10.16.
//  Copyright © 2016 niksemv. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    //@IBOutlet weak var collectionView: UICollectionView!
    
    var tableStore: TableStore
    
    init(row: Int, column: Int) {
        self.tableStore = TableStore(row: row, column: column)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        
    }
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 60 * CGFloat(tableStore.column), height: 60 * CGFloat(tableStore.row)), collectionViewLayout: CustomUICollectionViewFlowLayout(numberOfColumns: CGFloat(tableStore.column)))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tableCell")
        scrollView.addSubview(collectionView)
        scrollView.contentSize = collectionView.frame.size
        
        tableStore.collectionView = collectionView
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableStore.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableStore.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as? TableCollectionViewCell, let tableItemData = tableStore.itemData(indexPath: indexPath) {
            cell.update(data: tableItemData)
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if let cell = collectionView.cellForItem(at: indexPath) as? TableCollectionViewCell, let item =  tableStore.itemData(indexPath: indexPath) {
            item.color = UIColor.green
            cell.update(data: item)
            collectionView.reloadItems(at: [indexPath])
        }
        self.tableStore.findPath()
       
        
        
        print("You selected cell #\(indexPath)!")
    }
}
