class RestaurantBill
  attr_reader :ordered_items

  def initialize
    @ordered_items = []
  end

  def order_item(item, cost)
    @ordered_items << [item, cost]
  end

  def add_tax
    total = 0

    @ordered_items.each do |item|
      total += item[1]
    end

    total *= 1.096
  end
end
