class User < ActiveRecord::Base
  xss_terminate
  acts_as_authentic do |c| 
    login_field :email 
    validate_login_field :false 
  end
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
	
	belongs_to :shop
	attr_protected :shop_id
	
	def role_symbols
    roles.map { |role| role.name.underscore.to_sym }
  end
	
	def assign_role(role_name)
    role = Role.find_or_create_by_name(role_name.to_s)
    assignments.find_or_create_by_role_id(role.id)
  end
	
	def owner!
		assign_role(:owner)
	end
	
end
