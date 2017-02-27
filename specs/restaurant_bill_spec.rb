require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe "RestaurantBill" do
  before do
    @bill = RestaurantBill.new
  end

  it "A bill is created with an empty ordered_items" do
    @bill.ordered_items.must_be_instance_of Array
    @bill.ordered_items.length.must_equal 0
  end

  it "Method order_item includes new item in ordered_items" do
    @bill.order_item("apple", 1.0)
    @bill.ordered_items.must_include ["apple", 1.0]
  end

  it "Method order_item includes items when called multiple times" do
    @bill.order_item("apple", 1.0)
    @bill.order_item("soup", 7.5)
    @bill.order_item("tea", 2.0)

    @bill.ordered_items.must_include ["apple", 1.0]
    @bill.ordered_items.must_include ["soup", 7.5]
    @bill.ordered_items.must_include ["tea", 2.0]
  end

  it "add_tax returns total plus tax" do
    @bill.order_item("apple", 1.0)
    @bill.order_item("soup", 7.5)
    @bill.order_item("tea", 2.0)

    @bill.add_tax.must_equal (10.5 * 1.096)
  end

  it "add_tip returns total plus tip" do
    @bill.order_item("apple", 1.0)
    @bill.order_item("soup", 7.5)
    @bill.order_item("tea", 2.0)

    @bill.add_tip(15).must_equal (10.5 * 1.15)
  end

  it "doesn't allow negative tips" do
    proc { @bill.add_tip(-4) }.must_raise ArgumentError
  end

  it "final_cost returns total plus tax and tip" do
    @bill.order_item("apple", 1.0)
    @bill.order_item("soup", 7.5)
    @bill.order_item("tea", 2.0)
    @bill.add_tip(18)

    @bill.final_cost.must_equal (10.5 * 1.096) + (10.5 * 0.18)
  end
end
