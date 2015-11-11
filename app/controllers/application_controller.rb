class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  responders :flash

  before_action :set_nodes

  private

  def set_nodes
    @nodes = Node.all
  end
end
