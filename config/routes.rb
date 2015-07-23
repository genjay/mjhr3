Rails.application.routes.draw do

  get 'cardtimes/index'

  # get  'daily_duties/calculate' => 'daily_duties#get_calculate' 
  # post 'daily_duties/calculate' => 'daily_duties#post_calculate' 

  resources :cardtimes do 
    collection { post 'import'}
  end
  
  resources :daily_duties do
    collection do 
      post 'calculate', action: 'post_calculate'
      get  'calculate', action: 'get_calculate'
    end
  end

  resources :view_sch_deps, only: [:index, :edit]

  resources :view_sch_emps
  devise_for :users

  get 'home' => 'pages#home'
  get 'pages/home'
  root 'pages#home'

  resources  :employees, :subsidies, :overtypes, :departments, :offtypes, :worktypes, :ous, :lvlists, :annual_leave_lists, :pay_types, :catcodes, :insurance_settings, :doc_forgets, :doc_offworks, :doc_overworks, except: [:show, :destroy] do
    collection do
      delete 'multi_destroy'
    end
  end


   
end
