authorization do
  role :owner do
    has_permission_on :admin_products, :admin_themes, :admin_prototypes, :admin_option_types, :admin_properties, :admin_product_photos, :admin_product_properties, :to => [:index, :manage, :view]
		has_permission_on :admin_product_photos, :to => [:positions]
    #has_permission_on :authorization_rules, :to => :read
  end
end

privileges do
  privilege :change do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :moderate do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :view do
    includes :index, :show
  end
  
  privilege :act_as_god do
    includes :all
  end
  
  privilege :manage do
    includes :create, :new, :index, :show, :edit, :update, :delete, :destroy
  end
end