//
//  ProcotolController+Layout.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

private let ScreenWidth: CGFloat = UIScreen.main.bounds.width
private let ScreenHeight: CGFloat = UIScreen.main.bounds.height

private let protocol_url: String = "https://www.xuebaonline.com/%E7%BE%8E%E8%B1%AB%E7%9B%B4%E8%81%98%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE%E4%B8%8E%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96/"

extension ProcotolController {
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white

        navigationBarSetting()
        leftBarItemSeeting()
        initSubView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func initSubView() {
        webView = WebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TopMarginX.topMargin))
        view.addSubview(webView)
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        config.progressTintColor = UIColor(hex: "#333333")
        // 加载普通URL
        webView.webConfig = config
        webView.webloadType(self, .URLString(url: protocol_url))
    }

    private func leftBarItemSeeting() {
        let closeItem = UIBarButtonItem(image: Asset.back.image, style: .plain, target: self, action:
            #selector(pop))
        closeItem.tintColor = UIColor(hex: "#333333")
        navigationItem.leftBarButtonItem = closeItem
    }

    @objc private func pop() {
        navigationController?.popViewController(animated: true)
    }

    func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor.white /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black /// 修改返回按钮的颜色
    }
}
