Rails.application.routes.draw do

  resources :month_others
  # get 'month_duties/index'

  # get 'month_duties/calculate'

  get 'cardtimes/index'

  # get  'daily_duties/calculate' => 'daily_duties#get_calculate' 
  # post 'daily_duties/calculate' => 'daily_duties#post_calculate' 

  resources :cardtimes do 
    collection { post 'import'}
  end
  
  resources :daily_duties, :month_duties, :month_salaries do
    collection do 
      post 'calculate', action: 'post_calculate'
      get  'calculate', action: 'get_calculate'
    end
  end

  resources :calendars
  resources :view_sch_deps

  resources :view_sch_emps
  devise_for :users

  get 'home' => 'pages#home'
  get 'pages/home'
  get  'get_empid' => 'application#get_empid'
  root 'pages#home'

  resources  :doc_forgets, except: [:show, :destroy] do
    collection do
      get 'get_ViewSchEmp', action: 'get_ViewSchEmp'
      delete 'multi_destroy'
    end
  end

  resources  :doc_overworks, except: [:show, :destroy] do
    collection do
      get 'get_ViewSchEmp', action: 'get_ViewSchEmp'
      get 'create_overworks', action: 'create_overworks'
      delete 'multi_destroy'
    end
  end

  resources  :doc_offworks, :subsidies, :overtypes, :departments, :offtypes, :ous, :annual_leave_lists, :pay_types, :catcodes, :insurance_settings, except: [:show, :destroy] do
    collection do
      delete 'multi_destroy'
    end
  end

  resources  :lvtypes, except: [:show, :destroy] do
    resources :lvlists, except: [:show, :destroy] do
      collection do
        delete 'multi_destroy'
      end
    end
    collection do
      delete 'multi_destroy'
    end
  end

  resources  :worktypes, except: [:show, :destroy] do
    resources :workrests, except: [:show, :destroy] do
      collection do
        delete 'multi_destroy'
      end
    end
    collection do
      delete 'multi_destroy'
    end
  end

  resources  :employees, except: [:show, :destroy] do
    resources :employee_insurance_settings, except: [:show, :destroy] do
      collection do
        delete 'multi_destroy'
      end
    end
    resources :employee_salary_settings, except: [:show, :destroy] do
      collection do
        delete 'multi_destroy'
      end
    end
    resources :employee_inoutlogs, except: [:show, :destroy] do
      collection do
        delete 'multi_destroy'
      end
    end
    collection do
      delete 'multi_destroy'
    end
  end
   
end
