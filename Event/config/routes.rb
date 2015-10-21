Rails.application.routes.draw do

  match "todoevents/destroy_completed" => "todoevents#destroy_completed", :via => :delete
  match "todoevents/status_order" => "todoevents#status_order", :via => :post
  match "todoevents/indeindex" => "todoevents#indeindex", :via => :get
  match "todoevents/complete" => "todoevents#complete_all", :via => :post
  resources :todoevents
  root 'todoevents#index'

  match "todoevents/complete" => "todoevents#complete", :via => :post
  match "todoevents/add" => "todoevents#add", :via => :post
  match "todoevents/unmark" => "todoevents#unmark", :via => :post

end
