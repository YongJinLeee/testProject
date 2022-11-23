//
//  TabBarViewController.swift
//  testProject
//
//  Created by YongJin on 2022/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var defalutTabIndex = 0 {
        
        didSet {
            self.selectedIndex = defalutTabIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.selectedIndex = defalutTabIndex
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 홈 탭
        let homeNavigationController = UINavigationController()
        let homeViewContoller = HomeViewController()
        
        homeNavigationController.addChild(homeViewContoller)
        homeNavigationController.tabBarItem.title = "홈"
        homeNavigationController.tabBarItem.image = UIImage.init(systemName: "house")
        homeNavigationController.tabBarItem.selectedImage = UIImage.init(systemName: "house.fill")
        homeNavigationController.tabBarItem.selectedImage?.withTintColor(UIColor.red)
        
        // 좋아요 탭
        let wishListNavigationController = UINavigationController()
        let wishListViewController = WishListViewController()
        
        wishListNavigationController.addChild(wishListViewController)
        wishListNavigationController.tabBarItem.title = "좋아요"
        wishListNavigationController.tabBarItem.image = UIImage.init(systemName: "heart")
        wishListNavigationController.tabBarItem.selectedImage = UIImage.init(systemName: "heart.fill")
        wishListNavigationController.tabBarItem.selectedImage?.withTintColor(UIColor.red)
        
        let viewControllers = [homeNavigationController, wishListNavigationController] // array index 대로 탭 표시됨
        self.setViewControllers(viewControllers, animated: true)
        
    }
}


extension TabBarViewController {
    
}
