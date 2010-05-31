require 'spec_helper'

describe OptionValue do
  it "should create a new instance given valid attributes" do
		ov = Factory.build(:good_option_value)
		ov.valid?.should == true
  end

  it "shouldn't create a new instance given invalid attributes" do
		ov = Factory.build(:bad_option_value)
		ov.valid?.should == false
  end
end
