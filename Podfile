# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Storelink' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Storelink
  pod 'SnapKit', '~> 5.0.0'   # https://github.com/SnapKit/SnapKit
  pod 'SwiftGen'    # https://github.com/SwiftGen/SwiftGen
  pod 'SwiftLint'   # https://github.com/realm/SwiftLint
  pod 'RxSwift', '~> 5'   # https://github.com/ReactiveX/RxSwift   
  pod 'RxCocoa', '~> 5'   # https://github.com/ReactiveX/RxSwift
  pod 'InputMask'   # https://github.com/RedMadRobot/input-mask-ios
  pod 'IQKeyboardManagerSwift'   #https://github.com/hackiftekhar/IQKeyboardManager 
  pod 'ImageSlideshow'   # https://github.com/zvonicek/ImageSlideshow
  pod 'ImageSlideshow/SDWebImage'
  pod 'Hero'  # https://github.com/HeroTransitions/Hero
  pod 'GoogleMaps'   # https://github.com/googlemaps/maps-sdk-for-ios-samples  
  pod 'GooglePlaces'
  pod 'Moya/RxSwift', '~> 14.0'  # https://github.com/Moya/Moya


  # target 'StorelinkTests' do
  #   inherit! :search_paths
  #   # Pods for testing
  # end

  # target 'StorelinkUITests' do
  #   # Pods for testing
  # end

end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
         config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
   end
end
