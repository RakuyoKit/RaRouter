# pod lib lint --verbose --allow-warnings MBCRouter.swift.podspec
# pod trunk push --verbose --allow-warnings MBCRouter.swift.podspec

Pod::Spec.new do |s|
  
  s.name          = 'RaRouter'
  
  s.version       = '2.0.0'
  
  s.summary       = 'A simple router component.'
  
  s.description   = 'A simple, lightweight, high-freedom protocol-oriented router component.'
  
  s.homepage      = 'https://github.com/rakuyoMo/RaRouter.git'
  
  s.license       = 'MIT'
  
  s.author        = { 'Rakuyo' => 'wugaoyu@mbcore.com' }
  
  s.source        = { :git => 'https://github.com/rakuyoMo/RaRouter.git', :tag => s.version.to_s }
  
  s.requires_arc  = true
  
  s.platform      = :ios, '10.0'
  
  s.swift_version = '5.0'
  
  s.module_name   = 'RaRouter'
  
  s.static_framework = true
  
  s.source_files = 'RaRouter/RaRouter/Core/'
  
end
