class CreateSupplyOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :supply_orders do |t|
      t.belongs_to :customer
      t.integer :order_number
      t.date :date_entered
      t.date :due_date
      t.date :date_escalated
      t.date :completed_date
      t.boolean :completed
      t.timestamps
    end
  end
end
