require 'spec_helper'

describe OptionType do
  it "should create a new instance given valid attributes" do
		ot = Factory.build(:good_option_type)
		ot.valid?.should == true
		ot.save
		ot.name.should == 'kolor_ramki'
  end

  it "shouldm't create a new instance given invalid attributes" do
		ot = Factory.build(:bad_option_type)
		ot.valid?.should == false
		ot.should have(2).errors
  end
end
