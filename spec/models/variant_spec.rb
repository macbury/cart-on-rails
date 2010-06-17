require 'spec_helper'

describe Variant do
	
	it "should validate object" do
		variant = Factory.build(:good_variant)
		product = variant.product
		
		variant.valid?.should == true
		variant.save
	end
	
	it "shouldn't validate object" do
		#Factory.create(:good_variant)
		variant = Factory.build(:bad_variant)
		variant.valid?.should == false
		variant.save
		
		variant.should have(2).error_on(:price)
		variant.should have(1).error_on(:weight)
		variant.should have(0).error_on(:sku)
	end
	
end