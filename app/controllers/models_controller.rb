class ModelsController < ApplicationController

  def index 
    models = Model.all
    
    byebug 
    
    render json: models

  end

end
