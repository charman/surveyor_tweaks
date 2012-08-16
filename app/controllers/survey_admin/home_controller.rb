class SurveyAdmin::HomeController < ApplicationController
  #  Documentation for 'unloadable':
  #    http://apidock.com/rails/ActiveSupport/Dependencies/Loadable/unloadable
  unloadable
  include SurveyorTweaks::SurveyAdmin::HomeControllerMethods
end
