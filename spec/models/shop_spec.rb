require 'spec_helper'

describe Shop do
  it "should create a new instance given valid attributes" do
		shop = Factory.build(:good_shop)
		shop.valid?.should == true
  end

  it "should create a new instance given invalid attributes" do
		shop = Factory.build(:bad_shop)
		shop.valid?.should == false
		shop.should have(2).error_on(:title)
		shop.should have(1).error_on(:domain)
		shop.should have(2).error_on(:first_name)
		shop.should have(2).error_on(:street)
		shop.should have(2).error_on(:city)
		shop.should have(1).error_on(:zip_code)
		shop.should have(1).error_on(:phone)
		shop.should have(1).error_on(:birthdate)
  end

	it "should create folder for domain with content and delete it at end" do
		shop = Factory.create(:good_shop)
		File.exists?(shop.public_folder_path).should == true
		File.exists?(File.join([shop.public_folder_path, '/assets/'])).should == true
		shop.destroy
		File.exists?(shop.public_folder_path).should == false
  end
end
