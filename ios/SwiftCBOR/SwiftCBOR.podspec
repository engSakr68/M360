Pod::Spec.new do |s|
  s.name             = 'SwiftCBOR'
  s.version          = '0.4.5'
  s.summary          = 'A CBOR implementation in Swift'
  s.description      = <<-DESC
A CBOR (Concise Binary Object Representation) implementation in Swift.
                       DESC
  s.homepage         = 'https://github.com/valpackett/SwiftCBOR'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Val Packett' => 'val@packett.cool' }
  s.source           = { :git => 'https://github.com/valpackett/SwiftCBOR.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/SwiftCBOR/**/*.swift'
end
