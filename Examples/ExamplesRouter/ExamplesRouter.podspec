# pod lib lint --verbose --allow-warnings ExamplesRouter.podspec
# pod trunk push --verbose --allow-warnings ExamplesRouter.podspec

Pod::Spec.new do |s|
  
  s.name             = 'ExamplesRouter'
  
  s.version          = '1.0.0-Router'
  
  s.summary          = 'Examples Router.'
  
  s.description      = 'Examples Router.'
  
  s.homepage         = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => 'https://github.com/rakuyoMo/RaRouter.git', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'ExamplesRouter'
    
  s.source_files     = 'ExamplesRouter/ExamplesRouter/Router/'
  
  s.dependency 'RaRouter'
  
end
