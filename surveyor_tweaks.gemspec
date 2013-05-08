#  This gemspec file is based on this template:
#    https://github.com/wycats/newgem-template/blob/master/newgem.gemspec
#  as suggested by the "Make your own gem" RubyGems Guide:
#    http://guides.rubygems.org/make-your-own-gem/

require File.expand_path("../lib/surveyor_tweaks/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'surveyor_tweaks'
  s.version     = SurveyorTweaks::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Craig Harman"]
  s.email       = 'craig@craigharman.net'
  s.homepage    = 'https://github.com/charman/surveyor_tweaks'
  s.summary     = 'Tweaks to the Surveyor Gem'
  s.description = 'Adds some functionality to the Surveyor Gem - https://github.com/NUBIC/surveyor'

  #  If you have other dependencies, add them here
  s.add_dependency('surveyor', '~> 1.4.0')

  #  If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  #  If you need an executable, add it here
  # s.executables = ["newgem"]

  #  If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end
