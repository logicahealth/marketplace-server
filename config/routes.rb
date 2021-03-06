Rails.application.routes.draw do


    # match '*all' => 'application#cors_preflight_check', via: :options

    # Serve websocket cable requests in-process
    # mount ActionCable.server => '/websocket/:platform_id'
    mount ActionCable.server => '/websocket'

    # Service-related resources

    resources :licenses

    resources :services do
        member do
            post :publish
            post :unpublish
            get 'logo/large' => 'services#large', as: :large_logo
            get 'logo/medium' => 'services#medium', as: :medium_logo
            get 'logo/small' => 'services#small', as: :small_logo
        end
        resources :screenshots do
            member do
                get :large
                get :medium
                get :small
            end
        end
        collection do
            post :search, as: :search_services
        end
        resources :builds do
            member do
                resources :dependencies
                resources :exposures do
                    member do
                        resources :parameters
                    end
                end
                resources :configurations do
                    member do
                        resources :tasks
                    end
                end
            end
        end
    end

    resources :interfaces do
        member do
            resources :surrogates
        end
    end

    # IAM-related stuff

    resources :users do
        resources :identities
        resources :platforms do
            resources :instances
        end
    end

    resources :groups do
        resources :members
    end

    resources :roles do
        resources :appointments
    end
    
    resources :identity_providers do
        member do
            get		:redirect
            post	:enable
            post	:disable
        end
    end

    get		'sessions' => 'sessions#callback',		as: :callback
    post	'sessions' => 'sessions#authenticate',	as: :login
    delete	'sessions' => 'sessions#destroy',		as: :logout
    get 'dashboard' => 'welcome#dashboard',			as: :dashboard
    get 'status' => 'welcome#status',				as: :status

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    namespace :smart do
        get 'launch' => 'launch#launch'
    end
    # You can have the root of your site routed with "root"
    root 'welcome#landing'
end
