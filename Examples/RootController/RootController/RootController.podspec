# pod lib lint --verbose --allow-warnings RootController.podspec
# pod trunk push --verbose --allow-warnings RootController.podspec

Pod::Spec.new do |s|
  
  s.name          = 'RootController'
  
  s.version       = '1.0.0'
  
  s.summary       = 'RootController'
  
  s.description   = 'RootController'
  
  s.homepage      = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license       = 'MIT'
  
  s.author        = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source        = { :git => '', :tag => s.version.to_s }
  
  s.requires_arc  = true
  
  s.platform      = :ios, '10.0'
  
  s.swift_version = '5.0'
  
  s.module_name   = 'RootController'
  
  s.static_framework = true
  
  s.source_files = 'RootController/Core/', 'RootController/Router/'
  
  s.dependency 'RootControllerRouter', '>= 1.0.0-Router'
  
end
