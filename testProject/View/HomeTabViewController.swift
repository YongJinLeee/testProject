//
//  HomeTabViewController.swift
//  testProject
//
//  Created by YongJin on 2022/11/26.
//

import Foundation
import UIKit
import Foundation
import RxSwift
import RxCocoa
import SDWebImage
import Kingfisher
import SnapKit
import Then
import Alamofire


class HomeTabViewController: UIViewController {
    
    var initData: [Initializing] = []
    var bannerData: [Banner] = []
    var goodsData: [Good] = []
    
    var homeCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout().then {
            
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .horizontal
            $0.sectionInset = .zero
        }
        
        let homeView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = UIColor.systemGray
        }
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBar()
        getInitData()
//        getinitDataAlamo()
        
        view.addSubview(homeCollectionView)
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(bannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        homeCollectionView.register(GoodsListCell.self, forCellWithReuseIdentifier: "GoodsListCell")
        
    }
}

extension HomeTabViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {

        case 0:
            return bannerData.count
        default:
            return goodsData.count
        }

    }
    
    
    // 섹션에 따라 보여줄 Cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? bannerCell else { return UICollectionViewCell() }

            let imageURL = self.bannerData[indexPath.item].image
            // cell.imageView.kf.setImage(with: URL(string: imageURL)) // kingFisher 버전..
            cell.imageView.sd_setImage(with: URL(string: imageURL))
            cell.pageLabel.text = "\(bannerData[indexPath.item].id)/\(bannerData.count)"
            return cell

        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsListCell", for: indexPath) as? GoodsListCell else { return UICollectionViewCell() }

            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

}

extension HomeTabViewController {
    
    func setNaviBar() {

        navigationController?.navigationBar.backgroundColor = UIColor(r: 245, g: 245, b: 245, a: 0.5)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true

        navigationItem.title = "홈"
    }

    // 섹션별 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionType, environment -> NSCollectionLayoutSection? in
            
            guard let self = self else { return nil }

            return self.creatBannerTypeSection()
        }
    }

    // 배너 layoutSection
    private func creatBannerTypeSection() -> NSCollectionLayoutSection {

        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section

    }
    
    private func creatGoodsListTypeSection() -> NSCollectionLayoutSection {

        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section

    }

}

// ViewModel...?
extension HomeTabViewController {
    
    func getInitData() {

        ProjectAPIManager.initialization { initDataDTO in

            self.initData = [initDataDTO]
            self.bannerData = initDataDTO.banners
            self.goodsData = initDataDTO.goods
            
            print("bannar: \(self.bannerData)\ngoods: \(self.goodsData)")

        } onFailure: { (error) in
            print("\(error)")
        }
    }
    
    // 예비용 Alamofire
    func getinitDataAlamo() {
        
        ProjectAPIManager.getInitialData { initDataDTO in
            
            switch initDataDTO {
                
            case .success(let initData):
                
                self.bannerData = initData.banners
                self.goodsData = initData.goods
                
            case .failure(let error):
                print("\(error)")
            }
            
            print("bannar: \(self.bannerData)\ngoods: \(self.goodsData)")
        }
    }
}
