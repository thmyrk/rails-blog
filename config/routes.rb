Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create show destroy update] do
        member do
          get :export_to_xlsx
        end
      end

      resources :comments, only: %i[create show destroy update]
    end
  end
end
