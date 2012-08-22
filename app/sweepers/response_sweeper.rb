class ResponseSweeper < ActionController::Caching::Sweeper
  observe Response
  
  def after_create(response)
    expire_cache_for(response)
  end
  
  def after_destroy(response)
    expire_cache_for(response)
  end

  def after_update(response)
    expire_cache_for(response)
  end
  
private

  def expire_cache_for(response)
    expire_fragment("admin_responses_list_for_survey_#{response.response_set.survey.access_code}") 
  end

end
