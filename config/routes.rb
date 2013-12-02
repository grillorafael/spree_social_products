Spree::Core::Engine.routes.draw do
  namespace :admin do
    resource :social, :only => [:edit, :update], :controller => "social"
  end
end
