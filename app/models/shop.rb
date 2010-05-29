class Shop < ActiveRecord::Base
	xss_terminate
	
	validates_presence_of :first_name, :last_name, :domain, :title, :street, :zip_code, :city, :phone
	validates_uniqueness_of :domain, :title, :case_sensitive => false
	validates_length_of :domain, :within => 3..32
	validates_length_of :title, :first_name, :last_name, :street, :city, :within => 3..255
	validates_format_of :domain, :with => /^[A-Za-z0-9-]+$/
	validates_format_of :zip_code, :with => /^\d{2,3}-\d{3,4}$/
	validates_exclusion_of :domain, :in => %w( support blog www billing help api login admin )
	validates_and_formats_phones :phone, '###-###-###', '(###) ### ### #'
	
	validates_inclusion_of :birthdate,
	    :in => Date.new(1900)..18.years.ago.to_date,
	    :message => 'musisz mieć ukończone 18 lat'
	
	has_many :users, :dependent => :destroy
	has_many :products, :dependent => :destroy
	has_many :pages, :dependent => :destroy		

	attr_protected :users
	
	before_validation :downcase_subdomain
	after_create :setup_folder
	after_destroy :delete_folder
	
	def public_folder_path
		File.join([[Rails.root, "/public/store_assets/#{domain}/"]])
	end
	
	def setup_folder
		Dir.mkdir(public_folder_path) rescue true
		FileUtils.cp_r File.join([Rails.root,'/app/themes/default/assets/']), public_folder_path
	end
	
	def delete_folder
		FileUtils.rm_r(public_folder_path) rescue true
	end
	
	protected

	  def downcase_subdomain
	    self.domain.downcase! if attribute_present?("domain")
	  end
end
