Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "MRTextField"
s.summary = "Customized UITextField for iOS Developers"
s.requires_arc = true

# 2
s.version = "0.2.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Muhammad Raza Master" => "mrazam110@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/mrazam110/MRTextField"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/mrazam110/MRTextField.git", :tag => "#{s.version}"}



# 7
s.framework = "UIKit"

# 8
s.source_files = "MRTextField/**/*.{swift}"

# 9
#s.resources = "RWPickFlavor/**/*.{png,jpeg,jpg,storyboard,xib}"
end