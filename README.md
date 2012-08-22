# surveyor_tweaks

SurveyorTweaks provides additional functionality to users of the the Surveyor Gem (https://github.com/NUBIC/surveyor).

SurveyorTweaks:
* Provides an admin interface for viewing survey responses, accessible at '/survey_admin'
* Adds convenience methods for analyzing responses to the ResponseSet and Survey models


## Installation

Add surveyor_tweaks to your Gemfile:

    gem 'surveyor_tweaks', '0.0.2', :git => "git://github.com/charman/surveyor_tweaks_.git"

Then run:

    bundle install

Add these two include statements to 'app/models/response_set.rb' (if the file does not already exist, create it):

    class ResponseSet < ActiveRecord::Base
      include Surveyor::Models::ResponseSetMethods
      include SurveyorTweaks::Models::ResponseSetMethods
    end

Add these two include statements to 'app/models/survey.rb' (if the file does not already exist, create it):

    class Survey < ActiveRecord::Base
      include Surveyor::Models::SurveyMethods
      include SurveyorTweaks::Models::SurveyMethods
    end
