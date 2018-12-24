#
# Be sure to run `pod lib lint swiftArch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'swiftArch'
  s.version          = '1.2.0'
  s.summary          = 'swift开发脚手架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/manondidi/swiftArch'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'czq' => '790512128@qq.com' }
  s.source           = { :git => 'https://github.com/manondidi/swiftArch.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'swiftArch/Classes/**/**/*'
  
  
  s.dependency 'Closures', '~> 0.5'
  s.dependency 'HandyJSON', '~> 4.2.0' 
  s.dependency 'SnapKit', '~> 4.0.0'
  s.dependency 'MJRefresh'
  s.dependency 'RxAlamofire', '~>4.3.0'
  s.dependency 'RxSwift',    '~> 4.0'
  s.dependency 'RxCocoa',    '~> 4.0'
  s.dependency 'Toast-Swift', '~> 4.0.0'
  s.dependency 'Kingfisher', '~>4.8.0'
  s.dependency 'CocoaLumberjack/Swift'
  s.dependency 'UICollectionViewLeftAlignedLayout'

  s.swift_version = '4.2' 
  # s.resources = ['swiftArch/Assets/*.xib']
  # s.resource_bundles = {
  #     'swiftArch' => ['swiftArch/Assets/*.png']
  # }

#   s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
end
