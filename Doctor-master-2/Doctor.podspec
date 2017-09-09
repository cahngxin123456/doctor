Pod::Spec.new do |s|
  s.name         = 'Doctor'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'AFNetworking', '~> 3.1.0'
  s.dependencies =	pod 'SDWebImage', '~> 3.8.2'
  s.dependencies =	pod 'MJExtension', '~> 3.0.13'
  s.dependencies =	pod 'SVProgressHUD', '~> 2.1.2'
  s.dependencies =	pod 'MJRefresh', '~> 3.1.12'
  s.dependencies =	pod 'DACircularProgress', '~> 2.3.1'

end