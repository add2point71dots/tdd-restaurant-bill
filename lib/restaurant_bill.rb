class RestaurantBill
  attr_reader :ordered_items, :tip, :total

  def initialize
    @ordered_items = []
    @total = 0
    @tip = 0
  end

  def order_item(item, cost)
    @ordered_items << [item, cost]
  end

  def initial_total
    initial_total = 0
    @ordered_items.each do |item|
      initial_total += item[1]
    end
    @total = initial_total
    return initial_total
  end

  def add_tax
    @tax = initial_total * 0.096
    return initial_total * 1.096
  end

  def add_tip(percent)
    raise ArgumentError.new "You can't give a negative tip" if percent < 0
    @tip = initial_total * (percent / 100.0)
    return @total + @tip
  end

  def final_cost
    return add_tax + @tip
  end

end

bill = RestaurantBill.new
bill.order_item("apple", 1.0)
bill.order_item("soup", 7.5)
bill.order_item("tea", 2.0)
bill.add_tip(18)

puts bill.final_cost
