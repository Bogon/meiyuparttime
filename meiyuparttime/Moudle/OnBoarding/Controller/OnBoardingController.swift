//
//  OnBoardingController.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/12.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit
import paper_onboarding
import Hue
import RxSwift
import RxCocoa

class OnBoardingController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let items = [
        OnboardingItemInfo(informationImage: Asset.studying.image,
                           title: "信息丰富",
                           description: "\n可满足招聘者多元的求助需求，\n信息丰富，多维度考量",
                           pageIcon: Asset.key.image,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),

        OnboardingItemInfo(informationImage: Asset.texting.image,
                           title: "信息精准",
                           description: "\n有丰富的精准的职位信息，\n多元的职位，满足你求职需求",
                           pageIcon: Asset.wallet.image,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),

        OnboardingItemInfo(informationImage: Asset.working.image,
                           title: "直接沟通",
                           description: "\n为你提供直接便捷的沟通渠道，\n直接联系BOSS",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),

    ]
    
    /// 跳过按钮
    lazy var skipButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("跳过", for: .normal)
        button.setTitleColor(UIColor.init(hex: "#666666"), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#ffffff").alpha(0.6), size: CGSize(width: 80, height: 40)), for: .normal)
        button.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#ffffff").alpha(0.4), size: CGSize(width: 80, height: 40)), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        skipButton.rx.tap.subscribe(onNext: {
            /// 切换到跟控制器
            let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = delegate.getRootController()
        }).disposed(by: disposeBag)
        
    }
}

// MARK: PaperOnboardingDelegate
extension OnBoardingController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource
extension OnBoardingController: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}


//MARK: Constants
private extension OnBoardingController {
    
    static let titleFont = UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont.systemFont(ofSize: 14.0)
}
