//
//  AppDelegate.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/22.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit
import CBFlashyTabBarController
import AMScrollingNavbar
import IQKeyboardManagerSwift
import SideMenu
import DeviceKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var tabbar_height: CGFloat = 49
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        CBFlashyTabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        CBFlashyTabBar.appearance().barTintColor = .white
        
        /// 初始化数据库信息
        DatabaseInitlize.share.databaseInitlize()
        
        /// 首次登录
        FirstLaunch.firstLaunch()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        /// 设置侧边栏样式
        settingSideMenu()
        
        if FirstLaunch.isFirstLaunch() {
            window?.rootViewController = OnBoardingController()
        } else {
            /// 设置根视图
            window?.rootViewController = getRootController()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
         // 更新登录人的时间
         UserInfoHandle.share.relogin()
         IQKeyboardManager.shared.enable = true
        
         window?.makeKeyAndVisible()
         
        
        return true
    }
    
    /// 获取tabbar的高度
    func getTabbarHeight() -> CGFloat {
        return tabbar_height
    }

}

extension AppDelegate {
    
    /// 创建根控制器
    func getRootController() -> CBFlashyTabBarController {
        
        let jobListController = JobListController()
         jobListController.tabBarItem = UITabBarItem(title: "列表", image: Asset.jobList.image, tag: 0)
         
         let historyController = HistoryController()
         historyController.tabBarItem = UITabBarItem(title: "关注", image: Asset.jingxuan.image, tag: 1)
         
         let settingController = SettingController()
         settingController.tabBarItem = UITabBarItem(title: "我的", image: Asset.setting.image, tag: 2)

        let tabBarController = CBFlashyTabBarController()
         tabBarController.viewControllers = [
             ScrollingNavigationController(rootViewController: jobListController),
             ScrollingNavigationController(rootViewController: historyController),
             ScrollingNavigationController(rootViewController: settingController)]
        tabbar_height = tabBarController.tabBar.height
        return tabBarController
    }
    
    /// 设置side
    func settingSideMenu() {
        setupSideMenu()
        updateUI()
        updateMenus()
    }
        
    /// 设置SideMenu
    private func setupSideMenu() {
        // Define the menus
        /// 设置左边的侧边栏
        SideMenuManager.default.leftMenuNavigationController = SideMenuNavigationController(rootViewController: JobTypeVosController())
    }
        
    private func updateUI() {
        var settings: SideMenuSettings = SideMenuSettings()
            
        // let styles:[UIBlurEffect.Style] = [.dark, .light, .extraLight]
        settings.blurEffectStyle = .light
        settings.statusBarEndAlpha = 1 /// 让其跟随系统navigationbar
        settings.presentationStyle.menuStartAlpha = 1
        settings.presentationStyle.presentingEndAlpha = 1
        settings.presentationStyle.presentingScaleFactor = 1
        settings.presentationStyle.menuScaleFactor = 1
        settings.menuWidth = drawWidth
        settings.presentationStyle.onTopShadowOpacity = 0.5
        settings.enableSwipeToDismissGesture = false
    }
        
    private func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
        SideMenuManager.default.rightMenuNavigationController?.settings = settings
    }
        
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        presentationStyle.backgroundColor = UIColor.clear
        presentationStyle.menuStartAlpha = CGFloat(1)
        presentationStyle.menuScaleFactor = CGFloat(1)
        presentationStyle.onTopShadowOpacity = 0.5
        presentationStyle.presentingEndAlpha = CGFloat(1)
        presentationStyle.presentingScaleFactor = CGFloat(1)

        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        /// 适配iPhone 5，iPhone 5C，iPhone 5S，iPhone SE
        settings.menuWidth = drawWidth
        settings.blurEffectStyle = .light
        settings.statusBarEndAlpha = 1

        return settings
    }
        
    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return modes[0]
    }
}


