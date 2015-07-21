Pod::Spec.new do |spec|
  spec.name         = 'AuthenticationKit'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/petester42/AuthenticationKit'
  spec.authors      = { 'Pierre-Marc Airoldi' => 'pierremarcairoldi@gmail.com' }
  spec.summary      = 'Simplify authenication for iOS and OS X.'
  spec.source       = { :git => 'https://github.com/petester42/AuthenticationKit.git', :tag => spec.version }

  spec.ios.deployment_target = '8.0'
  spec.ios.vendored_frameworks = 'Carthage/Build/iOS/*.framework'

  spec.osx.deployment_target = '10.9'
  spec.osx.vendored_frameworks = 'Carthage/Build/Mac/*.framework'
end
