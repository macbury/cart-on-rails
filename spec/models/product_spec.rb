require 'spec_helper'

describe Product do
  it "should create a new instance given valid attributes" do
		product = Factory.build(:good_product)
		product.valid?.should == true
		product.save
		product.permalink.should == 'koszulka-ruby-on-rails'
		product.properties.should have(0).records
  end
	
	it "shouldn't create a new instance given invalid attributes" do
		product = Factory.build(:bad_product)
		product.valid?.should == false
		product.should have(2).errors
  end
	
	it "should clean html description and output polish characters" do
		product = Product.new

		product.description = "To jest test z literkami ąźżćńółę"
		product.description.should == "To jest test z literkami ąźżćńółę"
	end
	
	it "should create product properties and option_types from prototype_id" do
		shop = Factory.create(:good_shop)
		
		prototype = Factory.build(:good_prototype)
		prototype.shop_id = shop.id
		prototype.save
		
		property = Factory.build(:dynamic_property)
		property.shop_id = shop.id
		property.save
		
		prototype.properties << property
		
		option_type = Factory.build(:dynamic_option_type)
		option_type.shop_id = shop.id
		option_type.save
		
		prototype.option_types << option_type
		
		product = Factory.build(:dynamic_product)
		product.shop_id = shop.id
		product.prototype_id = prototype.id.to_s
		product.save
		
		product.properties.should have(1).records
		product.option_types.should have(1).records
  end
	
	it "should create product properties from array" do
		shop = Factory.create(:good_shop)
		product = Factory.build(:dynamic_product)
		product.shop_id = shop.id
		product.save
		
		properties = {}
		
		10.times do
			property = Factory.build(:dynamic_property)
			property.shop_id = shop.id
			property.save
			properties[property.id] = "testowa wartość"
		end
		
		create_properties = []
		10.times do |index|
			create_properties << { :name => "test #{index}", :value => "Test" }
		end
		
		product.create_properties_from_params!(properties, create_properties)
		product.properties.should have(20).records
	end

	it "should publish product" do
		product = Factory.create(:dynamic_product)
		product.published = true
		product.valid?.should == false
		
		product.should have(1).error_on(:published)
		
		product.variants << Factory.create(:good_variant)
		
		product.published = true
		product.valid?.should == true
	end
end
