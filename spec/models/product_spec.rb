require 'spec_helper'

describe Product do
  it "should create a new instance given valid attributes" do
		product = Factory.build(:good_product)
		product.valid?.should == true
		product.save
		product.permalink.should == 'koszulka-ruby-on-rails'
  end

  it "shouldn't create a new instance given invalid attributes" do
		product = Factory.build(:bad_product)
		product.valid?.should == false
		product.should have(2).errors
  end
end
