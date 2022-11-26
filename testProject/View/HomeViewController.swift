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
import SwiftUI

//class HomeViewController: UIViewController {
//}

class HomeViewController: UICollectionViewController {
    
    var initData: [Initializing] = []
    var bannerData: [Banner] = []
    var goodsData: [Good] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviBar()
        getInitData()
    
        collectionView.register(bannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(GoodsListCell.self, forCellWithReuseIdentifier: "GoodsListCell")

        collectionView.collectionViewLayout = layout()

    }

}


extension HomeViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {

        case 0:
            return bannerData.count
        default:
            return goodsData.count
        }

    }
    
    
    // 섹션에 따라 보여줄 Cell 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

}

// ViewModel 아닌가..?
extension HomeViewController {

    func getInitData() {

        ProjectAPIManager.initialization { initDataDTO in


            self.initData = [initDataDTO]
            self.bannerData = initDataDTO.banners
            self.goodsData = initDataDTO.goods

        } onFailure: { (error) in
            print("\(error)")
        }

    }
}

extension HomeViewController {

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



// swiftUI preview
struct HomeViewController_Previews: PreviewProvider {

    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }

        typealias UIViewControllerType = UIViewController
    }
}
