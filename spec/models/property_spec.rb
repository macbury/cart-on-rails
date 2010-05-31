require 'spec_helper'

describe Property do
  it "should create a new instance given valid attributes" do
		ot = Factory.build(:good_property)
		ot.valid?.should == true
		ot.save
		ot.name.should == 'typ_matrycy'
  end

  it "shouldn't create a new instance given invalid attributes" do
		ot = Factory.build(:bad_property)
		ot.valid?.should == false
		ot.should have(2).errors
  end
end
