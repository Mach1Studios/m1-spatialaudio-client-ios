Pod::Spec.new do |spec|
  spec.name          = "Mach1AudioPlayerAPI"
  spec.version       = "0.0.1"
  spec.summary       = "API helper for implementation of Mach1SpatialAPI"
  spec.description   = "This API helps you to implement Mach1SpatialAPI (https://cocoapods.org/pods/Mach1SpatialAPI) and use Motion Manager for detect device or headphones motion."
  
  spec.homepage      = "http://dev.mach1.tech"
  spec.license       = { :type => 'Commercial', :file => 'LICENSE.txt' }
  spec.author        = { 'Mach1' => 'https://www.mach1.tech' }
  spec.platform      = :ios, "14.0"
  spec.source        = { :git => 'https://github.com/Mach1Studios/m1-spatialaudio-client-ios.git', :tag => spec.version.to_s }
  spec.swift_version = "5.0"
  spec.source_files  = 'Mach1AudioPlayerAPI/*.{h,m,swift}', 'Mach1AudioPlayerAPI/**/*.{h,m,swift}'

  # Required dependencies
  spec.dependency 'Mach1SpatialAPI'

end
