# pod lib lint --verbose --allow-warnings GlobalDemoRouter.podspec
# pod trunk push --verbose --allow-warnings GlobalDemoRouter.podspec

Pod::Spec.new do |s|
  
  s.name             = 'GlobalDemoRouter'
  
  s.version          = '1.0.0-Router'
  
  s.summary          = 'GlobalDemo Router.'
  
  s.description      = 'GlobalDemo Router.'
  
  s.homepage         = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => '', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'GlobalDemoRouter'
    
  s.source_files     = 'GlobalRouter/Router/*'
  
  s.dependency 'RaRouter'
  
end
