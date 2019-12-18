#
# Be sure to run `pod lib lint KTMapFrameWork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KTMapFrameWork'
  s.version          = '0.1.10'
  s.summary          = 'A short description of KTMapFrameWork.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/181310067@qq.com/KTMapFrameWork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '181310067@qq.com' => 'huangzhentong@keytop.com.cn' }
  s.source           = { :git => '/Users/kt-stc08/Desktop/Git/KTMapFrameWork', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

 s.ios.deployment_target = '10.0'


  s.source_files = 'KTMapFrameWork/Classes/Module/**/*'
  s.resource = 'KTMapFrameWork/Assets/*'
  # s.resource_bundles = {
  #   'KTMapFrameWork' => ['KTMapFrameWork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'WebKit','Foundation','CoreLocation','ObjectiveC'
  # s.dependency 'AFNetworking', '~> 2.3'

s.vendored_frameworks = 'KTMapFrameWork/Classes/Framework/DMap.framework'

s.dependency  'Masonry'
#s.dependency 'IQKeyboardManager'
#s.dependency 'YYModel'
s.dependency'AFNetworking'
s.dependency 'SVProgressHUD'
#s.dependency 'AMapNavi-NO-IDFA'
end
