ActiveAdmin.register User, as: "Doctor" do

  permit_params :first_name, :position, :email, :password, :password_confirmation

  controller do
    def scoped_collection
      User.where(position: User.positions[:doctor])
    end
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  form do |f|
    f.inputs "Doctor" do
      f.input :position, :input_html => { :value => "doctor" }, as: :hidden
      f.input :first_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    selectable_column
    column :first_name
    column :email
    column :position

    actions
  end

end

ActiveAdmin.register User, as: "Patient" do

  permit_params :first_name, :position, :email, :password, :password_confirmation

  controller do
    def scoped_collection
      User.where(position: User.positions[:patient])
    end
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  form do |f|
    f.inputs "Patient" do
      f.input :position, :input_html => { :value => "patient" }, as: :hidden
      f.input :first_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    selectable_column
    column :first_name
    column :email
    column :position

    actions
  end

end