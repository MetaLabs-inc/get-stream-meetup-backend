Rails.application.routes.draw do
  resource :users, only: %I[create show] do
    collection do
      post :chat_token
    end
  end
end
