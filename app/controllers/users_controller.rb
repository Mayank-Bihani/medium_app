class UsersController < ApplicationController
    before_action :authenticate_user, except: [:register]
  
    
  end
  