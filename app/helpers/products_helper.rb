module ProductsHelper
  
  def search_check_box(type, object_id)
    param = params[:search][type] rescue nil
    if param.nil?
      selected = false
    else
      selected = param.map(&:to_i).include?(object_id) 
    end
    check_box_tag "search[#{type.to_s}][]", object_id, selected
  end
  
  def price(product)

    if (product.min_price == product.max_price)
      return to_zl(product.min_price)
    else
      return "od #{to_zl(product.min_price)} do #{to_zl(product.max_price)}"
    end
  end
  
  def to_zl(amt)
    number_to_currency(amt, :separator => ",", :delimiter => " ", :unit => "") + ' zł'
  end
  
  def product_url(product)
    "/#{product.permalink}"
  end
  
end
