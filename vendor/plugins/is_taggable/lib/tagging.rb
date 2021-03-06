class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  
  before_save :set_user
  
  protected
  
    def set_user
      self.user_id = taggable.user_id
    end
end
