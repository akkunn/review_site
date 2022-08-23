ActiveAdmin.register Review do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :curriculum, :support, :teacher, :compatibility,
                :thought, :user_id, :school_id, :curriculum_star,
                :support_star, :teacher_star, :compatibility_star, :average_star
  #
  # or
  #
  # permit_params do
  # permitted = [:name, :curriculum, :support, :teacher, :compatibility,
  #              :thought, :user_id, :school_id, :curriculum_star,
  #              :support_star, :teacher_star, :compatibility_star, :average_star]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
