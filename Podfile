source 'git://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def pod_dependencies
  pod 'KeyboardFrameChangeListener', '~> 1.0'
  pod 'ScrollViewKeyboardAvoider', '~> 1.0'
end

target 'ScrollViewControllerDemoApp' do
  pod_dependencies
end

target 'ScrollViewController' do
  pod_dependencies
end

target 'ScrollViewControllerTests' do
  pod_dependencies
  pod 'Quick', '~> 1.1'
  pod 'Nimble', '~> 7.0'
end
