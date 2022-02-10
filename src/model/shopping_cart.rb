require './src/model/order'

class ShoppingCart
  TABELA_DESCONT = {
    DIS_10: 0.1,
    DIS_15: 0.15,
    DIS_20: 0.20
  }

   TABELA_PONTOS = {
    DIS_10: 10,
    DIS_15: 15,
    DIS_20: 20
  }

  def initialize customer, products
    @customer = customer
    @products = products
  end

  def add_product product
    @products.push(product)
  end

  def remove_product product
    @products.delete_at(@products.index(product) || @products.length)
  end

=begin
    Checkout: Calculates total price and total loyalty points earned by the customer.
    Products with product code starting with DIS_10 have a 10% discount applied.
    Products with product code starting with DIS_15 have a 15% discount applied.

    Loyalty points are earned more when the product is not under any offer.
        Customer earns 1 point on every $5 purchase.
        Customer earns 1 point on every $10 spent on a product with 10% discount.
        Customer earns 1 point on every $15 spent on a product with 15% discount.
=end
  def apply_discount(product)
    discount = TABELA_DESCONT.select do |key,value|
      product.product_code.start_with?(key.to_s)
    end
    if discount != {}
      return product.price * discount.values[0] 
    else
      return 0
    end
  end

  def loyalty_points(product)
    discount = TABELA_PONTOS.select do |key,value|
      product.product_code.start_with?(key.to_s)
    end
    if discount != {}
      return product.price / discount.values[0]
    else
      return product.price / 5
    end
  end
  
  def checkout()
    total_price = 0
    loyalty_points_earned = 0

    @products.each do |product|
      discount = 0
      discount = apply_discount(product)
      loyalty_points_earned += loyalty_points(product)

      total_price += product.price - discount;
    end

    return Order.new total_price, loyalty_points_earned
  end

  def to_s
    "Customer: #{@customer.name}\n" +
    "Bought: \n#{@products.map { |product| "- #{product.name}, #{product.price}" }.join("\n")}"
   end

end
