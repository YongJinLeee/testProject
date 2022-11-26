//
//  GoodsListCell.swift
//  testProject
//
//  Created by YongJin on 2022/11/25.
//

import UIKit
import Foundation
import SnapKit
import Then
import SDWebImage


class GoodsListCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let wishBtn = UIButton().then {
        
        $0.isSelected = !$0.isSelected
        if $0.isSelected {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            $0.tintColor = UIColor.systemRed
            
        } else {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor.systemGray
        }

    }
}
