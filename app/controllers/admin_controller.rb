class AdminController < ApplicationController
  
  def index
    @users = User.non_admin_users
    @tickets = Ticket.all
  end
  
end
