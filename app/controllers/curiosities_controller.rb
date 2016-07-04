class CuriositiesController < ApplicationController
  def index
    @curiosities = Curiosity.all
  end
end
