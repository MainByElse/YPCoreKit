#
#  Be sure to run `pod spec lint YPCoreKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "YPCoreKit"
  spec.version      = "0.0.1"
  spec.summary      = "个人常用组件库"
  spec.description  = <<-DESC
                   DESC
  spec.homepage     = "http://EXAMPLE/YPCoreKit"
  spec.license      = "MIT"
  spec.author       = { "MainByElse" => "zeroliyanpeng@163.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "http://EXAMPLE/YPCoreKit.git", :tag => "#{spec.version}" }
  spec.requires_arc     = true
  spec.frameworks       = "Foundation", "UIKit"
  spec.source_files     = "Sources"

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.subspec "Core" do |ss|
    ss.source_files = "Sources/Core/**/*.{swift,h,m}"
  end

  # Components
  spec.subspec "Components" do |ss|
    ss.source_files = "Sources/Components"
    ss.dependency "RMCoreKit/Core"

  end

  # Extensions
  spec.subspec "Extensions" do |ss|
    ss.source_files = "Sources/Extensions"
  end

  # Utils
  spec.subspec "Utils" do |ss|
    ss.source_files = "Sources/Utils"
  end
end
