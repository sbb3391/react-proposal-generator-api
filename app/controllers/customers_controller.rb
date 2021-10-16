class CustomersController < ApplicationController

  def index 
    customers = Customer.all

    byebug

    render json: customers
  end
end
