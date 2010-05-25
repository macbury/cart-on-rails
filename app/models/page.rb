class Page < ActiveRecord::Base
  belongs_to :user
	has_many :pages, :class_name => "Page", :foreign_key => "layout_id", :dependent => :nullify
	belongs_to :layout, :class_name => "Page", :foreign_key => "layout_id"
  validates_presence_of :content, :name
  xss_terminate :except => [:content]
  
  @@types = ['Layout', 'Page', 'Snippet']
  
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
