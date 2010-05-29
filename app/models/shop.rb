class Shop < ActiveRecord::Base
	xss_terminate

	validates_presence_of :first_name, :last_name, :domain
	validates_uniqueness_of :domain, :case_sensitive => false
	validates_format_of :domain, :with => /^[A-Za-z0-9-]+$/
	validates_exclusion_of :domain, :in => %w( support blog www billing help api login admin )
	validates_acceptance_of :regulamin, :on => :create

	validates_inclusion_of :birthdate,
	    :in => Date.new(1900)..18.years.ago.to_date,
	    :message => 'musisz mieć ukończone 18 lat'
	
	has_many :users, :dependent => :destroy
	has_many :products, :dependent => :destroy
	has_many :categories, :dependent => :destroy
	has_many :vendors, :dependent => :destroy
	has_many :pages, :dependent => :destroy		

	attr_accessor :regulamin
	attr_protected :users
	
	before_validation :downcase_subdomain
	
	protected

	  def downcase_subdomain
	    self.domain.downcase! if attribute_present?("domain")
	  end
end
