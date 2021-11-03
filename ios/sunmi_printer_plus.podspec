#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sunmi_printer_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sunmi_printer_plus'
  s.version          = '0.0.1'
  s.summary          = 'Sunmi printer plus.'
  s.description      = <<-DESC
  Support V2 Pro Sunmi Label Version and Null safety. With this package you can connect with Sunmi printers, print text, image, qrcode, barcodes and a custom Esc/Pos if you like.
                       DESC
  s.homepage         = 'https://marcus.brasizza.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'mvbdesenvolvimento@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
