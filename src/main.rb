require './src/model/product'
require './src/model/customer'
require './src/model/shopping_cart'

def main
  product_1 = Product.new(10.0, "DIS_10_PRODUCT1", "product 1")
  product_2 = Product.new(20.0, "DIS_10_PRODUCT2", "product 2")
  products = [product_1, product_2]

  customer = Customer.new('A Customer')

  shopping_cart = ShoppingCart.new(customer, products)

  product_3 = Product.new(30.0, "DIS_10_PRODUCT3", "product 3")
  shopping_cart.add_product(product_3)

  puts shopping_cart.to_s

  order = shopping_cart.checkout
  puts order.to_s
end
