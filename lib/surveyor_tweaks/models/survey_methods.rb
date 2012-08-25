module SurveyorTweaks
  module Models
    module SurveyMethods

      def self.included(base)
        base.send :scope, :with_response_sets, :include => { :response_sets => {:responses => [ :question, :answer ] } }
      end


      def completed_response_sets
        ResponseSet.where(["survey_id = ?", self.id]).where("completed_at IS NOT NULL")
      end

      def total_completed_responses
        self.response_sets ? self.response_sets.count(:conditions => "completed_at IS NOT NULL") : 0
      end

    end
  end
end
