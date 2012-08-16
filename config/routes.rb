Rails.application.routes.draw do
  namespace 'survey_admin' do
    match '/' => 'home#index'
    match 'responses/:survey_access_code/list' => 'responses#list'
  end

  #  This is a legacy wild controller route that's not recommended for RESTful applications.
  #  Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))', :controller => /survey_admin\/[^\/]+/
end
