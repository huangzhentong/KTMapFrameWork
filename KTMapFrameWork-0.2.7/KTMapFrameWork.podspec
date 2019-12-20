Pod::Spec.new do |s|
  s.name = "KTMapFrameWork"
  s.version = "0.2.7"
  s.summary = "A short description of KTMapFrameWork."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"181310067@qq.com"=>"huangzhentong@keytop.com.cn"}
  s.homepage = "https://github.com/181310067@qq.com/KTMapFrameWork"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "WebKit", "Foundation", "CoreLocation", "CoreBluetooth"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '10.0'
  s.ios.vendored_framework   = 'ios/KTMapFrameWork.embeddedframework/KTMapFrameWork.framework'
end
