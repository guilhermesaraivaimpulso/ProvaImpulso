class HomeController < ApplicationController
  def index
    @materiais = Material.all
  end
end