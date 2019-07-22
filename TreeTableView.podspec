
Pod::Spec.new do |spec|

  spec.name = "TreeTableView"
  spec.version = "0.1.0"
  spec.summary = "Easiest usage of expandable & collapsible cells"

  spec.homepage = "https://github.com/AntonLisovoy/TreeTableView"

  spec.license = { :type => "MIT", :file => "LICENSE.md" }

  spec.author = { "Anton Lisovoy" => "lisovoy@arcsinus.ru" }
  spec.social_media_url = "https://twitter.com/AntonLisovoy"

  spec.platform = :ios
  spec.ios.deployment_target = "9.0"

  spec.source = { :git => "https://github.com/AntonLisovoy/TreeTableView.git", :tag => "#{spec.version}" }

  spec.source_files = "TreeTableView/**/*.{swift}"

  spec.framework  = "UIKit"

  spec.swift_version = "5.0"
  spec.requires_arc = true

end
