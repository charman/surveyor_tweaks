module SurveyorTweaks
  module SurveyAdmin
    module ResponsesControllerMethods

      def self.included(base)
        base.send :layout, 'survey_admin'
        base.send :helper_method, :responses_should_be_grouped?, :unique_response_texts_with_totals, :text_for_response
      end

      # cache_sweeper :response_sweeper, :response_set_sweeper
      # 


      def for_question
        @question = Question.find(params[:id])
        @responses = Response.where(["question_id = ?", @question.id])
        @survey = @question.survey_section.survey
      end

      def list
        @survey_access_code = params[:survey_access_code]
        @survey = Survey.find_by_access_code(@survey_access_code)
      end

      def questions_for_survey
        @survey = Survey.find(params[:id])
        @survey_sections = @survey.sections_with_questions.with_includes
      end

      def show
        @response_set = ResponseSet.with_responses.find(params[:id])
        @survey = @response_set.survey
    
        #  'with_includes' is an ActiveRecord scope that does some eager loading to speed up the SQL query
        @survey_sections = @survey.sections_with_questions.with_includes
      end


    private

      def responses_should_be_grouped?(responses)
        responses && responses.first && responses.first.answer.response_class != 'text'
      end

      def text_for_response(response)
        case response.answer.response_class
        when 'answer'
          response.answer.short_text
        when 'integer'
          response.integer_value
        when 'string'
          response.string_value
        when 'text'
          response.text_value
        else
          "UNHANDLED RESPONSE CLASS - #{response.answer.response_class}"
        end
      end

      def unique_response_texts_with_totals(responses)
        #  Filter out responses where the same Answer was chosen multiple times for a given ResponseSet
        answer_and_response_set_id_set = Set.new
        unique_responses = responses.select { |response| answer_and_response_set_id_set.add?([response.response_set_id, response.answer_id]) }
    
        responses_grouped_by_response_text = unique_responses.group_by { |r| text_for_response(r) }
    
        texts_with_totals = Hash.new
    
        responses_grouped_by_response_text.each do |response_text, array_of_identical_response_texts|
          texts_with_totals[response_text] = array_of_identical_response_texts.size
        end
    
        return texts_with_totals
      end

    end
  end
end
