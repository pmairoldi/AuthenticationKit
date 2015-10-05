Pod::Spec.new do |s|
  s.name             = "AuthenticationKit"
  s.version          = "0.2.0"
  s.summary          = "Simplify Authentication"
  s.homepage         = "https://github.com/petester42/AuthenticationKit"
  s.license          = 'MIT'
  s.author           = { "Pierre-Marc Airoldi" => "pierremarcairoldi@gmail.com" }
  s.source           = { :git => "https://github.com/petester42/AuthenticationKit.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true

  s.source_files = 'AuthenticationKit/Core/*'
  s.ios.source_files = 'AuthenticationKit/iOS/*'
  s.osx.source_files = 'AuthenticationKit/Mac/*'
end
