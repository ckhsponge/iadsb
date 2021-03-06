#
# Be sure to run `pod lib lint iADSB.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iADSB'
  s.version          = '0.1.0'
  s.summary          = 'A wrapper for ADS-B hardware that obtains location, speed, course, attitude, traffic, weather, etc.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/ckhsponge/iadsb'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christopher Hobbs' => 'purposemc@gmail.com' }
  s.source           = { :git => 'https://github.com/ckhsponge/iadsb.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.source_files = 'iadsb/Classes/**/*'
  
  # s.resource_bundles = {
  #   'iadsb' => ['iadsb/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.7'
  s.dependency 'ObjectiveWMM'
  s.dependency 'Starscream', '~> 3.0.2'
  
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'
end
