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
		
		shop.should have(2).error_on(:email)
		shop.should have(1).error_on(:password)
		shop.should have(1).error_on(:password_confirmation)
  end

	it "should create folder for domain with content and delete it at end" do
		shop = Factory.create(:good_shop)
		File.exists?(shop.public_folder_path).should == true
		#File.exists?(File.join([shop.public_folder_path, '/assets/'])).should == true
		shop.destroy
		File.exists?(shop.public_folder_path).should == false
  end
	
	it "should load default template for this shop" do
		shop = Factory.create(:good_shop)
		File.exists?(File.join([shop.public_folder_path, '/assets/'])).should == true
		shop.themes.should have(5).records
		
		shop.themes.each do |template|
			File.open(File.join([Theme.default_template_path('default'),'/views/', "#{template.name}.radius"]), "r") do |file|
				template.content.should == file.read
			end
		end

		shop.destroy
	end
	
	it "should create owner user for this object" do
		shop = Factory.create(:good_shop)
		owner = shop.users.first
		owner.role_symbols.include?(:owner).should == true
		shop.destroy
	end
end
