module SurveyorTweaks
  module SurveyAdmin
    module HomeControllerMethods

      def self.included(base)
        base.send :layout, 'survey_admin'
      end


      def index
        @surveys = Survey.all
      end

    end
  end
end
