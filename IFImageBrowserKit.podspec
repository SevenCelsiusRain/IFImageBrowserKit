#
# Be sure to run `pod lib lint IFImageBrowserKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IFImageBrowserKit'
  s.version          = '0.0.0.2'
  s.summary          = '图片预览'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
图片预览组件
                       DESC

  s.homepage         = 'https://ifgitlab.gwm.cn/iov-ios/IFImageBrowserKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张高磊' => 'mrglzh@yeah.net' }
  s.source           = { :git => 'http://10.255.35.174/iov-ios/IFImageBrowserKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'IFImageBrowserKit/Classes/**/*'
  s.resource = 'IFImageBrowserKit/Assets/*.bundle'
  
  s.dependency 'IFCommonKit'
  s.dependency 'YYImage'
  s.dependency 'SDWebImage'
end
