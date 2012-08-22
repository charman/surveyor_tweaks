class ResponseSetSweeper < ActionController::Caching::Sweeper
  observe ResponseSet
  
  def after_create(response_set)
    expire_cache_for(response_set)
  end
  
  def after_destroy(response_set)
    expire_cache_for(response_set)
  end

  def after_update(response_set)
    expire_cache_for(response_set)
  end
  
private

  def expire_cache_for(response_set)
    expire_fragment("admin_responses_list_for_survey_#{response_set.survey.access_code}") 
  end

end
