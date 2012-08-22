module SurveyAdmin::ResponsesHelper

  def table_rows_for_responses(response_set, question)
    html_output = ''
    responses = response_set.responses_for_question(question)

    if responses.size > 0
      html_output = "<tr><td>#{link_to question.text, :controller => 'survey_admin/responses', :action => 'for_question', :id => question.id}</td>" +
        "<td id=\"response_id_#{responses.first.id}\">#{text_for_response(responses.first)}</td></tr>"

      responses.drop(1).each do |response|
        html_output << "<tr><td>...</td><td id=\"response_id_#{response.id}\">#{text_for_response(response)}</td></tr>"
      end
    end

    return html_output
  end
  
  def total_response_sets_for_question(q)
    Response.count('response_set_id', :distinct => true, :conditions => ["question_id = ?", q.id])
  end
  
end
