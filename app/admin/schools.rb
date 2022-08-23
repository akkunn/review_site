ActiveAdmin.register School do

  permit_params :name, :style, :support, :guarantee, :explanation,
                :language_id, :prefecture_id, :cost_id, :period_id,
                :review_ave_score, :review_count, :image, :site_address

  index do
    selectable_column
    column(:id)
    column(:name)
    column(:style)
    column(:support)
    column(:guarantee)
    column(:explanation)
    column(:language.name)
    column(:prefecture.name)
    column(:cost_id) do |school|
      school.cost.range
    end
    column(:period_id) do |school|
      school.period.range
    end
    column(:review_ave_score)
    column(:review_count)
    column(:site_address)
    column(:created_at)
    column(:updated_at)
    column(:published)
    actions
  end

  show do
    attributes_table do
      row(:id)
      row(:name)
      row(:style)
      row(:support)
      row(:guarantee)
      row(:explanation)
      row(:language.name)
      row(:prefecture.name)
      row(:cost_id) do |school|
        school.cost.range
      end
      row(:period_id) do |school|
        school.period.range
      end
      row(:review_ave_score)
      row(:review_count)
      row(:site_address)
      row(:created_at)
      row(:updated_at)
      row(:published)
    end
    active_admin_comments
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :style, :support, :guarantee, :explanation, :language_id, :prefecture_id, :cost_id, :period_id, :review_ave_score, :review_count, :site_address
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :style, :support, :guarantee, :explanation, :language_id, :prefecture_id, :cost_id, :period_id, :review_ave_score, :review_count, :site_address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
