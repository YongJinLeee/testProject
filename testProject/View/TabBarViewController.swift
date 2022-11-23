//
//  TabBarViewController.swift
//  testProject
//
//  Created by YongJin on 2022/11/23.
//

import UIKit
import Then

class TabBarViewController: UITabBarController {
    
    var defalutTabIndex = 0 {
        
        didSet {
            self.selectedIndex = defalutTabIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = defalutTabIndex
        setUI()
         
    }
}


extension TabBarViewController {
    
    func setUI(){
        
        self.view.backgroundColor = .white
        UITabBar.appearance().scrollEdgeAppearance = .init()
        
        let tabBar: UITabBar = self.tabBar
        tabBar.tintColor = UIColor.systemRed
        tabBar.backgroundColor = UIColor(r: 245, g: 245, b: 245, a: 0.3)
        tabBar.unselectedItemTintColor  = UIColor.systemGray
        
        // 홈 탭
        let homeNavigationController = UINavigationController()
        let homeViewContoller = HomeViewController()
        
        homeNavigationController.addChild(homeViewContoller)
        homeNavigationController.tabBarItem.title = "홈"
        homeNavigationController.tabBarItem.image = UIImage.init(systemName: "house")
        homeNavigationController.tabBarItem.selectedImage = UIImage.init(systemName: "house.fill")
        
        // 좋아요 탭
        let wishListNavigationController = UINavigationController()
        let wishListViewController = WishListViewController()
        
        wishListNavigationController.addChild(wishListViewController)
        wishListNavigationController.tabBarItem.title = "좋아요"
        wishListNavigationController.tabBarItem.image = UIImage.init(systemName: "heart")
        wishListNavigationController.tabBarItem.selectedImage = UIImage.init(systemName: "heart.fill")
        
        let viewControllers = [homeNavigationController, wishListNavigationController] // array index 대로 탭 표시됨
        self.setViewControllers(viewControllers, animated: true)
        
    }
    
}
