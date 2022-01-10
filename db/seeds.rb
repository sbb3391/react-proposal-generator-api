require 'faker'

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

20.times do

  date_ent = time_rand(Time.local(2021,12,20), Time.local(2021,12,23))

  SupplyOrder.create(
    customer_id: 20,
    order_number: rand(10000..50000),
    date_entered: date_ent,
    date_escalated: date_ent + 3.days,
    due_date: date_ent + 5.days,
    completed: false
  )
end

