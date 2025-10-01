Pod::Spec.new do |s|
  s.name             = 'AmplitudeSwiftBinary'
  s.version          = '1.0.0'
  s.summary          = 'Local binary pod for AmplitudeSwift only.'
  s.homepage         = 'https://amplitude.com'
  s.license          = { :type => 'Proprietary', :text => 'See upstream' }
  s.author           = { 'Amplitude' => 'support@amplitude.com' }
  s.source           = { :http => 'file:./' } # local folder
  s.platform         = :ios, '12.0'
  s.swift_version    = '5.0'
  s.vendored_frameworks = 'AmplitudeSwift.xcframework'
  # IMPORTANT: no dependency on 'AmplitudeCore' and do not vendor it here.
end
