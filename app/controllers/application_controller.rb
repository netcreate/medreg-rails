class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def overview
    @groups = Group.all
    if params[:group_id]
      @students = Group.find_by_id(params[:group_id]).students
    end
  end
end
