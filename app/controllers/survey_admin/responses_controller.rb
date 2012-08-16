class SurveyAdmin::ResponsesController < ApplicationController
  #  Documentation for 'unloadable':
  #    http://apidock.com/rails/ActiveSupport/Dependencies/Loadable/unloadable
  unloadable
  include SurveyorTweaks::SurveyAdmin::ResponsesControllerMethods
end
