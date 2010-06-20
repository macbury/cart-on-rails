require 'spec_helper'

describe Photo do
	
	it "should parse size" do
		photo = Photo.new
		photo.folder_name(200,100,true).should == "200x100_crop"
		photo.folder_name(200,100,false).should == "200x100"
		photo.folder_name_from_size("200x100").should == "200x100"
		photo.folder_name_from_size("200x100", true).should == "200x100_crop"
		Photo.size_from_string("200x100").should == [200, 100]
	end
	
	it "should create valid" do
		shop = Factory.create(:good_shop)
		product = Factory.build(:dynamic_product)
		product.shop_id = shop.id
		product.save
		
		photo = product.photos.new
		photo.image = File.open(File.join([Rails.root, "spec", "files", "shirt.jpeg"]))
		photo.valid?.should == true
		photo.save.should == true
		
		photo.generate_photo_for_size(100,200, true)
		file_path = File.join([photo.folder_path(100,200,true), photo.file_name])
		File.exists?(file_path).should == true
		
		photo.generate_photo_for_size(300,200, false)
		file_path = File.join([photo.folder_path(300,200,false), photo.file_name])
		File.exists?(file_path).should == true
	end
	
end