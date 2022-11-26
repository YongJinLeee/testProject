//
//  bannerCell.swift
//  testProject
//
//  Created by YongJin on 2022/11/25.
//

import UIKit
import Foundation
import SnapKit
import Then

class bannerCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let pageLabel = UILabel().then { label in
        
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(r: 34, g: 34, b: 34, a: 0.3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.clear
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        contentView.addSubview(pageLabel)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageLabel.snp.makeConstraints {
            
            $0.width.equalTo(20)
            $0.height.equalTo(10)
            $0.trailing.bottom.equalToSuperview().offset(20)
    
        }
        
    }
    
    
}
