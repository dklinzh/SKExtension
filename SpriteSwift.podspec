Pod::Spec.new do |s|
  s.name                      = "SpriteSwift"
  s.version                   = "1.0.0"
  s.summary                   = "SpriteSwift"
  s.homepage                  = "https://github.com/dklinzh/SpriteSwift.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Daniel Lin" => "linzhdk@gmail.com" }
  s.source                    = { :git => "https://github.com/dklinzh/SpriteSwift.git.git", :tag => s.version.to_s }
  s.swift_version             = "5.1"
  s.source_files              = "Sources/**/*"

  s.ios.deployment_target     = "8.0"
  s.ios.frameworks            = "Foundation", "UIKit", "SpriteKit"

  s.osx.deployment_target     = "10.11"
  s.osx.frameworks            = "Foundation", "SpriteKit"
end
