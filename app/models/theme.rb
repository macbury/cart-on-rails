class Theme < ActiveRecord::Base
	@@types = [:layout, :page, :snippet, :collections, :product, :not_found, :cart, :search]
	
  belongs_to :shop
	has_many :themes, :class_name => "Theme", :foreign_key => "layout_id", :dependent => :nullify
	has_many :products, :dependent => :nullify
	belongs_to :layout, :class_name => "Theme", :foreign_key => "layout_id"
  validates_presence_of :content, :name
	validates_uniqueness_of :name, :scope => :shop_id
  xss_terminate :except => [:content]
  validates_inclusion_of :page_type, :in => 0..@@types.size

	attr_protected :shop_id, :default
	
	def self.type_index(t)
		index = 0
    @@types.each_with_index do |pt,i|
			index = i if pt.to_s =~ /#{t.to_s}/i
		end
		
		index
  end
	
	named_scope :product_type_theme, :conditions => { :page_type => Theme.type_index(:product)}
	
	def self.install_template_for_shop(name, shop)
		template_path = Theme.default_template_path(name)
		FileUtils.cp_r(File.join([template_path,'/assets/']), shop.public_folder_path)
		template_config = YAML.load_file(File.join([template_path,'config.yml']))
		template_config['templates'].each do |layout_name, pages_type|
			layout = shop.themes.new(:name => layout_name, :page_type => Theme.type_index(:layout))
			layout.default = true
			layout.load_content_from_file(File.join([template_path,'/views/', "#{layout_name}.radius"]))
			
			if layout.save
				pages_type.each do |type, pages|
					pages.each do |page_name|
						page = shop.themes.new(:name => page_name, :page_type => Theme.type_index(type), :layout_id => layout.id)
						page.default = true
						page.load_content_from_file(File.join([template_path,'/views/', "#{page_name}.radius"]))

						page.save
					end
				end
			end
		end
	end
	
	def load_content_from_file(path)
		File.open(path, "r") do |file|
			self.content = file.read
		end
	end
	
	def self.default_template_path(name='default')
		File.join([Rails.root,'/app/themes/', "/#{name}/"])
	end
	
  def self.types
    a = []
    @@types.each_with_index do |type, index|
      a << [type, index]
    end
    
    return a
  end
  
  def self.type_name(t)
    @@types.at(t.to_i)
  end

  def type_name
    @@types[self.page_type.to_i]
  end
end
