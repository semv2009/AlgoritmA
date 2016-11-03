//
//  TableCollectionViewCell.swift
//  AlgoritmA
//
//  Created by Семен Никулин on 26.10.16.
//  Copyright © 2016 niksemv. All rights reserved.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gLabel: UILabel!
    
    @IBOutlet weak var hLabel: UILabel!
    
    @IBOutlet weak var fLabel: UILabel!
    
    @IBOutlet weak var indexLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func update(data: TableItemData) {
        backgroundColor = UIColor.black
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1
        
        contentView.backgroundColor = data.color
        
        if data.isValue {
            setHiddenLabel(isNeed: data.isValue)
            gLabel.text = "\(data.G)"
            hLabel.text = "\(data.H)"
            fLabel.text = "\(data.F)"
        }
        //imageVew.image = UIImage(named: "grass2")
        
        indexLabel.text = "(\(data.index.section) \(data.index.row))"
    }
    
    func setHiddenLabel(isNeed value: Bool) {
        gLabel.isHidden = !value
        hLabel.isHidden = !value
        fLabel.isHidden = !value
    }

}
