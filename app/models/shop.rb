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
	validate :validate_owner, :on => :create
	
	validates_inclusion_of :birthdate,
	    :in => Date.new(1900)..18.years.ago.to_date,
	    :message => 'musisz mieć ukończone 18 lat'
	
	has_many :users, :dependent => :destroy
	has_many :products, :dependent => :destroy
	has_many :option_types, :dependent => :destroy
	has_many :prototypes, :dependent => :destroy
	has_many :properties, :dependent => :destroy
	has_many :themes, :dependent => :destroy		

	attr_accessor :email, :password, :password_confirmation
	
	before_validation :downcase_subdomain
	after_create :setup_folder, :create_owner, :load_defult_template
	after_destroy :delete_folder

	def validate_owner
		u = User.new(:email => self.email, :password => self.password, :password_confirmation => self.password_confirmation)
		unless u.valid?
			u.errors.each do |attribute, error|
				self.errors.add attribute, error
			end
		end
	end
	
	def public_folder_path
		File.join([[Rails.root, "/public/store_assets/#{domain}/"]])
	end
	
	def setup_folder
		Dir.mkdir(public_folder_path) rescue true
	end
	
	def space_consumed
		size = 0
		Dir.glob(File.join([public_folder_path, "/**/*"])).each do |filename|
			size += File.size(filename)
		end
		size
	end
	
	def space_left
		50.megabytes - space_consumed
	end
	
	def create_owner
		u = self.users.create(:email => self.email, :password => self.password, :password_confirmation => self.password_confirmation)
		u.owner!
	end
	
	def delete_folder
		FileUtils.rm_r(public_folder_path) rescue true
	end
	
	def load_defult_template
		Theme.install_template_for_shop('default', self)
	end
	
	protected

	  def downcase_subdomain
	    self.domain.downcase! if attribute_present?("domain")
	  end
end
