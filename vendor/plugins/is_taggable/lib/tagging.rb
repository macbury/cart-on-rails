class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  
  before_save :set_user
  
  protected
  
    def set_user
      self.shop_id = taggable.shop_id
    end
end
