require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'JigraPreferences'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = 'https://jigrajs.web.app'
  s.author = package['author']
  s.source = { :git => 'https://github.com/familyjs/jigra-plugins.git', :tag => package['name'] + '@' + package['version'] }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}', 'preferences/ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target  = '13.0'
  s.dependency 'Jigra'
  s.swift_version = '5.1'
end
