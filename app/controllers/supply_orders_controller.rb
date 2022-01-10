class SupplyOrdersController < ApplicationController

  def index 
    supply_orders = SupplyOrder.all.sort { |a,b| a.date_entered - b.date_entered}

    render json: supply_orders
  end

  def update
    supply_order = SupplyOrder.find(params[:id])

    params[:supply_order].keys.each {|k| supply_order[k] = params[:supply_order][k]}

    supply_order.save
    
    render json: supply_order
  end


end
