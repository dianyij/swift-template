platform :ios, '12.0'

target 'Demo' do
  use_frameworks!
  inhibit_all_warnings!

  #ReactiveX
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxViewController'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'

  # Networking
  pod 'Alamofire'
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'
  pod 'SDWebImage'
  
  # JSON
  pod 'KakaJSON'

  # Storage
  pod 'KeychainAccess'

  # Logging
  pod 'CocoaLumberjack/Swift'

  # UI
  pod 'UITextView+Placeholder'
  pod 'MJRefresh'
  pod 'MBProgressHUD'
  pod 'DZNEmptyDataSet'

  # Utils
  pod 'IQKeyboardManagerSwift'
  pod 'SnapKit'
  pod 'Device'
  pod 'R.swift'
  pod 'SwiftLint'

  target 'DemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DemoUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  # This removes the warning about swift conversion
  installer.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
  installer.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
  installer.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999

  # Set Deployment Target iOS Version
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
