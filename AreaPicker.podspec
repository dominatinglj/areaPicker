Pod::Spec.new do |s|
  s.name             = "AreaPicker"
  s.version          = "0.1"
  s.summary          = "中国省市县选择器"
  s.description      = <<-DESC
                       中国省市县选择器啊
                       DESC
  s.homepage         = "https://github.com/dominatinglj/areaPicker"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "liaojun" => "junliao3344@gmail.com" }
  s.source           = { :git => "https://github.com/dominatinglj/areaPicker.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '7.0'
	s.resource     = 'AreaPicker/lib/ProvincesCitiesAreas.plist'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'AreaPicker/lib/*.{h,m}'
  # s.resources = 'AreaPicker/lib/ProvincesCitiesAreas.plist'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end