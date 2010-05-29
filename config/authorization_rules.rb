authorization do
  role :owner do
    has_permission_on :admin_products, :admin_pages, :admin_categories, :to => [:index, :manage, :view]
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