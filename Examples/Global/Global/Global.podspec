# pod lib lint --verbose --allow-warnings GlobalDemo.podspec
# pod trunk push --verbose --allow-warnings GlobalDemo.podspec

Pod::Spec.new do |s|
  
  s.name             = 'GlobalDemo'
  
  s.version          = '1.0.0'
  
  s.summary          = 'GlobalDemo.'
  
  s.description      = 'GlobalDemo.'
  
  s.homepage         = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => '', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'GlobalDemo'
    
  s.source_files     = 'Global/Router/*'
  
  s.dependency 'RaRouter'
  
end
