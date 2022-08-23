ActiveAdmin.register Question do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :content, :user_id, :school_id, :solution
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :content, :user_id, :school_id, :solution]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
