Pod::Spec.new do |s|
  s.name                  = 'ScrollViewController'
  s.version               = '1.1.1'
  s.summary               = 'Controls UIScrollView so the content is in the right place'
  s.homepage              = 'https://github.com/darrarski/ScrollViewController'
  s.author                = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.social_media_url      = 'https://twitter.com/darrarski'
  s.license               = { :type => 'MIT', 
                              :file => 'LICENSE' }
  s.source                = { :git => 'https://github.com/darrarski/ScrollViewController.git', 
                              :tag => "v#{s.version}" }
  s.platform              = :ios
  s.ios.deployment_target = '10.0'
  s.source_files          = 'Sources'
  s.requires_arc          = true
  s.frameworks            = 'UIKit'
end
