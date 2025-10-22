Rails.application.routes.draw do
  # API versiyonlama için '/api/v1' namespace'i kullanıyoruz.
  namespace :api do
    namespace :v1 do
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
