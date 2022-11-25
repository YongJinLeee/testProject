//
//  HomeViewController.swift
//  testProject
//
//  Created by YongJin on 2022/11/22.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import SDWebImage
import Kingfisher
import SnapKit
import Then

class HomeViewController: UIViewController {
    
    // 상단 배너
    var bannerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout().then {
            
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .horizontal
            $0.sectionInset = .zero
        }
        
        let bannerView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = UIColor.systemGray
        }
        return bannerView
    }()
    
    var goodsListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout().then {
            
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .horizontal
            $0.sectionInset = .zero
        }
        
        let goodsListView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = UIColor.systemGray
        }
        return goodsListView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bannerCollectionView)
        view.addSubview(goodsListCollectionView)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        
    }

}


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == bannerCollectionView {
            
            return 3
        } else {
            
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
    }
    
    
    
    
}
