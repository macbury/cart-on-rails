require 'spec_helper'

describe Prototype do
  it "should create a new instance given valid attributes" do
		prototype = Factory.create(:good_prototype)
		prototype.valid?.should == true
  end

  it "shouldn't create a new instance given invalid attributes" do
		prototype = Factory.build(:bad_prototype)
		prototype.valid?.should == false
		prototype.should have(1).error_on(:name)
  end
end