Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'get_id', to: 'articles#get_id'
      get 'get_langs_list', to: 'articles#get_langs_list'
      get 'words_count', to: 'articles#words_count'
    end
  end
end
