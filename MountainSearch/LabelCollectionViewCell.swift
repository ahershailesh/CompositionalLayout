//
//  LabelCollectionViewCell.swift
//  PersonnelProject
//
//  Created by Shailesh Aher on 28/12/19.
//  Copyright © 2019 Shailesh Aher. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showBoarder()
    }
    
    private func showBoarder() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        contentView.backgroundColor = UIColor.yellow
    }
    
}
