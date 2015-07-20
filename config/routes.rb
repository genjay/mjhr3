Rails.application.routes.draw do


  resources :view_sch_deps
  resources :view_sch_deps, only: [:index, :edit]

  resources :view_sch_emps
  devise_for :users
  # resources :employees do
  #   resources :employee_insurance_setting
  # end
  # resources :lvlists
  # resources :subsidies
  # resources :insurance_settings
  # resources :insurance_settings
  # resources :catcodes
  # resources :pay_types
  # resources :annual_leave_lists
  get 'home' => 'pages#home'
  get 'pages/home'
  root 'pages#home'

  resources  :employees, :subsidies, :overtypes, :departments, :offtypes, :worktypes, :ous, :lvlists, :annual_leave_lists, :pay_types, :catcodes, :insurance_settings, :doc_forgets, except: [:show, :destroy] do
    collection do
      delete 'multi_destroy'
    end
  end

  # resources :departments do #, except: [:new] do
  #   collection do
  #     delete 'multi_destroy'
  #   end
  # end



  # resources :worktypes do
  #   resources :workrests
  # end
  # resources :ous
   
end
