module SurveyorTweaks
  module Models
    module ResponseSetMethods

      def self.included(base)
        base.send :scope, :with_responses, :include => { :responses => [:question, :answer] }
      end


      def most_recent_response_created_at
        if responses_sorted_by_created_at.last
          responses_sorted_by_created_at.last.created_at
        end
      end

      def responses_for_question(q)
        if q.pick == 'any'
          #  When a user can select multiple answers to a single question (e.g. check a box for any of A1, A2, A3, A4),
          #  we've encountered a bug in Surveyor (as of 0.21.0) where the software lets the user choose the same 
          #  answer multiple times (by creating multiple Response instances in a ResponseSet that point to the same
          #  Answer instance).  Since checkboxes can't be checked off multiple times, we only want to return one
          #  Response per Answer.
          #
          #  We test for and reject duplicates using by the Set.add?() method.
          answer_id_set = Set.new
          self.responses.select { |response| response.question_id == q.id && answer_id_set.add?(response.answer_id) }
        else 
          self.responses.select { |response| response.question_id == q.id }
        end
      end

      def responses_sorted_by_created_at
        @cached_sorted_responses ||= self.responses.sort { |response_a, response_b| response_a.created_at <=> response_b.created_at }
      end

      def seconds_between_first_and_last_responses
        if responses_sorted_by_created_at.last
          responses_sorted_by_created_at.last.created_at - responses_sorted_by_created_at.first.created_at
        end
      end

      def total_questions_answered
        self.responses.collect { |response| response.question_id }.uniq.size

        #  OPTIMIZATION NOTE -- In practice, when displaying a view where this method is called for several
        #  hundred response sets, the code above ("CollectCode") runs faster than this code ("CountCode"):
        #     
        ## Response.count('question_id', :distinct => true, :conditions => ["response_set_id = ?", self.id])
        #
        #  If the Response instances for this ResponseSet have already been loaded into memory from the database
        #  by invoking 'self.responses', then the CountCode will hit the database a second time, while the
        #  CollectCode will not.  If the Response instances are NOT already loaded into memory, then invoking
        #  'self.responses' will run a 'SELECT' query - but there doesn't seem to be any difference in speed
        #  between a 'SELECT' vs. 'COUNT' query for this dataset, so it's better to run the 'SELECT' query
        #  and load/cache the Response instances into memory.
      end

      def total_questions_answered_from_question_list(question_list)
        question_list_set = Set.new
        question_list.each { |question| question_list_set.add(question.id) }

        all_questions_answered_set = Set.new
        self.responses.each { |response| all_questions_answered_set.add(response.question_id) }

        #  Return size of intersection of the two sets = # questions from the list that were answered
        (question_list_set & all_questions_answered_set).size
      end

      def total_survey_sections_with_responses
        Question.count(
          #  Count distinct number of survey sections
          'survey_section_id', :distinct => true,
          #  Look only at responses that belong to this response set
          :conditions => ["responses.response_set_id = ?", self.id],
          #  Join 'responses' and 'questions' tables, since we need to count survey_section_id's, which is a field in
          #   the 'questions' but not the 'responses' table
          :joins => "INNER JOIN responses ON questions.id = responses.question_id")   
      end

    end
  end
end
