require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: "someCategory")
    @category.save
  end


describe 'Validations' do
  it 'should save product when all required fields are filled' do
    @product = Product.new(name: 'money tree', price: 1101, quantity: 5, category: @category)
    expect(@product).to be_valid
  end

  it 'should throw an error if there is no name' do
    @product = Product.new(name: nil, price: 1101, quantity: 5, category: @category)
    @product.save
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end

  it 'should throw an error if there is no price' do
    @product = Product.new(name: 'money tree', quantity: 5, category: @category)
    @product.save
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  it 'should throw an error if there is no quantity' do
    @product = Product.new(name: 'money tree', price: 1101, quantity: nil, category: @category)
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

  it 'should throw an error if there is no category' do
    @product = Product.new(name: 'money tree', price: 1101, quantity: 5, category: nil)
    @product.save
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end
end
  end