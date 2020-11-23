//
//  OnBoardingController+Layout.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/12.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import paper_onboarding
import SnapKit

extension OnBoardingController {
    override func loadView() {
        super.loadView()
        initSubView()
    }

    private func initSubView() {
        view.addSubview(skipButton)
        skipButton.isHidden = true

        setupPaperOnboardingView()
        view.bringSubviewToFront(skipButton)
    }

    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        skipButton.snp.remakeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-15)
            make.top.equalTo(view.snp.top).offset(50)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
}
