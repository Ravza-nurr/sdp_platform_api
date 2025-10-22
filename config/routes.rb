Rails.application.routes.draw do
  # API versiyonlama için '/api/v1' namespace'i kullanıyoruz.
  namespace :api do
    namespace :v1 do
      get "reports/index"
      get "reports/show"
      get "reports/create"
      get "reports/update"
      get "reports/destroy"
      get "credit_transactions/index"
      get "credit_transactions/show"
      get "credit_transactions/create"
      get "credit_transactions/update"
      get "credit_transactions/destroy"
      get "analyses/index"
      get "analyses/show"
      get "analyses/create"
      get "analyses/update"
      get "analyses/destroy"
      get "responses/index"
      get "responses/show"
      get "responses/create"
      get "responses/update"
      get "responses/destroy"
      get "surveys/index"
      get "surveys/show"
      get "surveys/create"
      get "surveys/update"
      get "surveys/destroy"
      get "scales/index"
      get "scales/show"
      get "scales/create"
      get "scales/update"
      get "scales/destroy"
      get "users/index"
      get "users/show"
      get "users/create"
      get "users/update"
      get "users/destroy"
      # 7 çekirdek model için RESTful rotaları tanımla
      resources :users
      resources :scales
      resources :surveys
      resources :responses
      resources :analyses
      resources :credit_transactions
      resources :reports
    end
  end
end
