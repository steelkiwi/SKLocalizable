Pod::Spec.new do |s|

  s.name         = "SKLocalizable"
  s.version      = "1.0.5"
  s.summary      = "Localization add-on for native iOS components"

  s.description  = <<-DESC
  Add-on for native iOS components for easy-connected project localization
                   DESC

  s.homepage     = "https://github.com/steelkiwi/SKLocalizable"
  s.license      = {
    :type => "MIT",
    :file => "LICENSE"
  }
  s.author       = { "Steelkiwi Inc." => "olesenko@steelkiwi.com" }

  s.platform     = :ios
  s.source       = {
    :git => "https://github.com/steelkiwi/SKLocalizable.git",
    :tag => s.version
  }
  s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '4.1' }
  s.swift_version         = "4.1"

  s.source_files  = "Classes", "Sources/**/*.swift"

end
