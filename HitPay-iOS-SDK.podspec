#
# Be sure to run `pod lib lint HitPay-iOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HitPay-iOS-SDK'
  s.version          = '0.1.3'
  s.summary          = 'HitPay-iOS-SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hit-pay/ios-sdk-example'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HITPAY PAYMENT SOLUTIONS PTE LTD' => 'tuannguyenanh177@gmail.com' }
  s.source           = { :git => 'https://github.com/hit-pay/ios-sdk-example.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.swift_version = '5.0'
  s.ios.deployment_target  = '11.0'

  s.vendored_frameworks = 'HitPay-iOS-SDK/HitPay_iOS_SDK.xcframework'
  s.dependency 'StripeTerminal', '~> 2.0'
end
