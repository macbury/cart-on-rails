class Theme < ActiveRecord::Base
	@@types = ['Layout', 'Page', 'Snippet']
  belongs_to :shop
	has_many :themes, :class_name => "Theme", :foreign_key => "layout_id", :dependent => :nullify
	belongs_to :layout, :class_name => "Theme", :foreign_key => "layout_id"
  validates_presence_of :content, :name
	validates_uniqueness_of :name, :scope => :shop_id
  xss_terminate :except => [:content]
  validates_inclusion_of :page_type, :in => 0..@@types.size

  
	attr_protected :shop_id, :default
	
	def self.install_template_for_shop(name, shop)
		template_path = Theme.default_template_path(name)
		FileUtils.cp_r(File.join([template_path,'/assets/']), shop.public_folder_path)
		template_config = YAML.load_file(File.join([template_path,'config.yml']))
		template_config['views'].each do |layout_name, pages_for_layout|
			layout = shop.themes.new(:name => layout_name, :page_type => Theme.type_index('Layout'))
			layout.default = true
			layout.load_content_from_file(File.join([template_path,'/views/', "#{layout_name}.radius"]))
			
			if layout.save
				pages_for_layout.each do |page_name|
					page = shop.themes.new(:name => page_name, :page_type => Theme.type_index('Page'), :layout_id => layout.id)
					page.default = true
					page.load_content_from_file(File.join([template_path,'/views/', "#{page_name}.radius"]))

					page.save
				end	
			end
		end
		
		template_config['snippets'].each do |snippet_name|
			snippet = shop.themes.new(:name => snippet_name, :page_type => Theme.type_index('Snippet'))
			snippet.default
			snippet.load_content_from_file(File.join([template_path,'/views/', "#{snippet_name}.radius"]))
			snippet.save
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
  
	def self.type_index(t)
		index = 0
    @@types.each_with_index do |pt,i|
			index = i if pt =~ /#{t}/i
		end
		
		index
  end

  def type_name
    @@types[self.page_type.to_i]
  end
end
