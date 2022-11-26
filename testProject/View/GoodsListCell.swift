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
            $0.tintColor = UIColor(r: 236, g: 94, b: 101)
            
        } else {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor.systemGray
        }

    }
    
    // FIXME: 라벨 하나로 사용하고 attribute에서 할인율 부분만 컬러 적용
    let discountLateLbl = UILabel().then {
        
        $0.textColor = UIColor(r: 236, g: 94, b: 101)
    }
    
    let priceLbl = UILabel().then {
        
        $0.textColor = UIColor.black
    }
    let nameLbl = UILabel().then {
        
        $0.textColor = UIColor(r: 119, g: 119, b: 119)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
