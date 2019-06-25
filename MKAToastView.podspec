Pod::Spec.new do |s|
  s.name          = "MKAToastView"
  s.version       = "1.2.0"
  s.summary       = "MKAToastView is the view that displays short message."
  s.description   = <<-DESC
  MKAToastView is the view that disappears automatically after displaying a short message for a few seconds like Android's Toast.
                   DESC
  s.homepage      = "https://github.com/HituziANDO/MKAToastView"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = "Hituzi Ando"
  s.platform      = :ios, "9.3"
  s.source        = { :git => "https://github.com/HituziANDO/MKAToastView.git", :tag => "#{s.version}" }
  s.source_files  = "MKAToastView/MKAToastView/**/*.{h,m}"
  s.exclude_files = "MKAToastView/build/*", "MKAToastView/Framework/*"
  s.requires_arc  = true
end
