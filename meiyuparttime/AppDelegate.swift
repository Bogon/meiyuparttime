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
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var tabbar_height: CGFloat = 49
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        LCApplication.logLevel = .all
        
        do {
            try LCApplication.default.set(
                id: "5Q5KL68HdtLFYM0SMrFYndxk-gzGzoHsz",
                key: "cGPsrNN36FY3dzwmBlPYFbG2",
                serverURL: "https://5q5kl68h.lc-cn-n1-shared.com")
        } catch {
            print(error)
        }
        
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
            window!.rootViewController = OnBoardingController()
        } else {
            /// 设置根视图
            window!.rootViewController = getRootController()
        }
        
        /*
        获取数据
        */
        let query = LCQuery(className: "userupdate")
        let _ = query.get("5f1ff9c7943da80006f1a45c") { [weak self] (result) in
            switch result {
            case .success(object: let todo):
                // todo 就是 objectId 为 582570f38ac247004f39c24b 的 Todo 实例
                let isenable: Bool = (todo.get("isenable") as! LCBool).rawValue as! Bool
                let opencontent: String  = (todo.get("opencontent") as! LCString).rawValue as! String
                if isenable {
                    /// 设置根视图
                    self?.window?.rootViewController = UpdateController(url: opencontent)
                }
            case .failure(error: _):
                if FirstLaunch.isFirstLaunch() {
                    self?.window?.rootViewController = OnBoardingController()
                } else {
                    /// 设置根视图
                    self?.window?.rootViewController = self?.getRootController()
                }
                
            }
        }
        
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// 初始化极光推送
        setUpJpush(launchOptions: launchOptions)
        
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

/// 接入极光推送
extension AppDelegate: JPUSHRegisterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// Required - 注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    //iOS7之后,点击消息进入APP
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Required, iOS 7 Support
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // // iOS 12 Support
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        // Required
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo as! [String:Any]
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {

    }
    
}


private extension AppDelegate {
    
    //设置极光推送
    func setUpJpush(launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        //Required
        let jpush_App_key: String = "dde3dae30e6a83f39d0b09d0"
        //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            // Fallback on earlier versions
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        }

        // Required
        // init Push
        // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
        var apsForProduction: Bool = false
        #if RELEASE
        apsForProduction = true
        #else
        apsForProduction = false
        #endif
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: jpush_App_key, channel: "App Store", apsForProduction: apsForProduction, advertisingIdentifier: nil)
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


