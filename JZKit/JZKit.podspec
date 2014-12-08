Pod::Spec.new do |s|
  s.name         = 'JZKit'
  s.version      = '0.0.1'
  s.summary      = 'A common tool kit for IOS dev.'
  s.homepage     = 'https://github.com/JoeyZeng/JZKit'
  s.license      = 'MIT'
  s.author             = { 'JoeyZeng' => 'zzying77@qq.com' }
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/JoeyZeng/JZKit.git', :branch => 'master' }
  s.source_files = 'JZKit/Classes/*.{h,m}'
  s.requires_arc = true
end
