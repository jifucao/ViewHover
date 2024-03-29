#
# Be sure to run `pod lib lint ViewHover.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewHover'
  s.version          = '0.1.2'
  s.summary          = 'Easy hover effect on NSView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jifucao/ViewHover'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jifu' => 'jifucao@gmail.com' }
  s.source           = { :git => 'https://github.com/jifucao/ViewHover.git', :tag => s.version.to_s }

  s.platform = :osx
  s.osx.deployment_target = "10.10"

  s.source_files = 'ViewHover/Classes/**/*'
  s.swift_version = '5.0'

end
