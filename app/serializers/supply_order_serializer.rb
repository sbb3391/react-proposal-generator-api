class SupplyOrderSerializer < ActiveModel::Serializer
  attributes :id, :customer, :customer_id, :date_entered, :due_date,
    :date_escalated, :completed, :order_number

  def customer
    Customer.find(self.object.customer_id).customer_name
  end
end
