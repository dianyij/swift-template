platform :ios, '12.0'

target 'Demo' do
  use_frameworks!
  inhibit_all_warnings!

  # ReactiveX
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxDataSources' # https://github.com/RxSwiftCommunity/RxDataSources
  pod 'RxSwiftExt' # https://github.com/RxSwiftCommunity/RxSwiftExt
  pod 'NSObject+Rx' # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxViewController' # https://github.com/devxoul/RxViewController
  pod 'RxGesture' # https://github.com/RxSwiftCommunity/RxGesture
  pod 'RxOptional' # https://github.com/RxSwiftCommunity/RxOptional
#  pod 'RxTheme' # https://github.com/RxSwiftCommunity/RxTheme
#  pod 'RxAnimated' # https://github.com/RxSwiftCommunity/RxAnimated

  # Networking
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'
  
  # Image
  pod 'SDWebImage'
  
  # JSON
  pod 'KakaJSON'

  # Storage
  pod 'KeychainAccess' # https://github.com/kishikawakatsumi/KeychainAccess

  # Logging
  pod 'CocoaLumberjack/Swift'
  
  # Date
  pod 'DateToolsSwift'  # https://github.com/MatthewYork/DateTools
  pod 'SwiftDate'  # https://github.com/malcommac/SwiftDate

  # Fabric
#  pod 'Fabric'
#  pod 'Crashlytics'
  
  # UI
  pod 'UITextView+Placeholder'
  pod 'MJRefresh'
  pod 'MBProgressHUD'
  pod 'Toast-Swift' # https://github.com/scalessec/Toast-Swift
  pod 'NVActivityIndicatorView' # https://github.com/ninjaprox/NVActivityIndicatorView
  pod 'DZNEmptyDataSet' # https://github.com/dzenbot/DZNEmptyDataSet
  pod 'Hero' # https://github.com/lkzhao/Hero
  pod 'RAMAnimatedTabBarController' # https://github.com/Ramotion/animated-tab-bar
  pod 'AcknowList' # https://github.com/vtourraine/AcknowList
  pod 'WhatsNewKit' # https://github.com/SvenTiigi/WhatsNewKit
  pod 'HMSegmentedControl' # https://github.com/HeshamMegid/HMSegmentedControl
  pod 'FloatingPanel' # https://github.com/SCENEE/FloatingPanel
  pod 'MessageKit' # https://github.com/MessageKit/MessageKit
  pod 'MultiProgressView' # https://github.com/mac-gallagher/MultiProgressView
  
  # Code Quality
  pod 'FLEX', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX
  pod 'SwifterSwift' # https://github.com/SwifterSwift/SwifterSwift
  pod 'BonMot' # https://github.com/Rightpoint/BonMot

  # Utils
  pod 'IQKeyboardManagerSwift'
  pod 'SnapKit'
  pod 'Device'
  pod 'R.swift'
  pod 'SwiftLint'
  
  # Analytics
#  pod 'Firebase/Analytics'
#  pod 'Firebase/Crashlytics'

  # Ads
#  pod 'Firebase/AdMob'
#  pod 'Google-Mobile-Ads-SDK', '~> 7.0'

  target 'DemoTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    #pod 'RxNimble', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxNimble
    pod 'RxAtomic', :modular_headers => true
    pod 'RxBlocking'  # https://github.com/ReactiveX/RxSwift
#    pod 'Firebase'
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

  # Cocoapods optimization, always clean project after pod updating
  Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
    flag_name = File.basename(script, ".sh") + "-Installation-Flag"
    folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
    file = File.join(folder, flag_name)
    content = File.read(script)
    content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
    File.write(script, content)
  end
end
