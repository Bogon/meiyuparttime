# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

project 'meiyuparttime.xcodeproj'
target 'meiyuparttime' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for meiyuparttime
# Rx
  pod 'RxSwift', '~> 5.1.1'                       # RxSwift is a Swift implementation
  pod 'RxCocoa', '~> 5.1.1'                       # RxSwift Cocoa extensions
  pod 'RxBlocking', '~> 5.1.1'                    # RxSwift Blocking operatos
  pod 'RxAlamofire', '~> 5.5.0'                   # RxSwift HTTP networking in Swift Alamofire
  pod 'NSObject+Rx', '~> 5.1.0'                   # Handy RxSwift extensions on NSObject.
  pod 'RxDataSources'
  
# Networking
  pod 'Moya', '~> 14.0.0'
  pod 'Moya/RxSwift', '~> 14.0.0'
  pod 'ObjectMapper', '~> 4.2.0'                  # Simple JSON Object mapping written in Swift
  pod 'Kingfisher'
  
# Data Store
  pod 'AwesomeCache', '~> 5.0'
  pod 'LeanCloud'

  pod 'JCore', '2.1.4-noidfa' # 必选项
  pod 'JPush', '3.2.4-noidfa' # 必选项

# UI
  pod 'SnapKit'                                    # Harness the power of auto layout
  pod 'Hue'
  pod 'MJRefresh'
  pod 'AMScrollingNavbar'
  pod 'CBFlashyTabBarController'
  pod 'Reusable'
  pod 'DeviceKit'
  pod 'JVFloatLabeledTextField'
  pod 'IQKeyboardManagerSwift'
  pod 'SideMenu'
  pod 'paper-onboarding'
  
# Data persistence
  pod 'FMDB', '~> 2.7.5'
  pod 'LKDBHelper', '~> 2.5.3', :inhibit_warnings => true
  
# 添加UIy调试框架
  pod 'LookinServer', :configurations => ['Debug']
  
  target 'meiyuparttimeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'meiyuparttimeUITests' do
    # Pods for testing
  end

end
