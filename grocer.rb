require 'pry'

def consolidate_cart(cart)
  hash = {}
  cart.each { |item|
    if hash.key?(item.keys[0]) 
      hash[item.keys[0]][:count] += 1
    else
      hash[item.keys[0]] = {
        :price => item.values[0][:price],
        :clearance => item.values[0][:clearance],
        :count => 1
      }
    end
  }
  return hash
end

def apply_coupons(cart, coupons)
  coupons.each do |i|
<<<<<<< HEAD
    if cart.keys.include?(i[:item])
      if cart[i[:item]][:count] >= i[:num]
        if cart["#{i[:item]} W/COUPON"]
          cart["#{i[:item]} W/COUPON"][:count] += i[:num]
        else
          cart["#{i[:item]} W/COUPON"] = {
            :price => i[:cost] / i[:num],
            :clearance => cart[i[:item]][:clearance],
            :count => i[:num] 
          }
        end
        cart[i[:item]][:count] -= i[:num]
=======
    if cart.keys.includes?(i[:item])
      cart["#{i[:item]} W/COUPON"] = {
        :price => i[:cost] / i[:num],
        :clearance => cart[i[:item]][:clearance],
        :count => i[:num]
      }
      if cart[i[:item]][:count] >= i[:num]
        cart[i[:item]][:count] = cart[i[:item]][:count] - i[:num]
>>>>>>> 775324b4f1206f9a12e52b75c07fcc04578160db
      end
    end
  end
  return cart
end
=begin
  change coupons to hash
    check if item = cart key
    add coupon to cart
    update count of original key
  
  #cart = hash - {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  #coupons = array - [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
=end

def apply_clearance(cart)
  cart.each do |item, values|
    if values[:clearance]
      values[:price] = (values[:price] * 0.8).round(1)
    end
  end 
  cart
end

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end

