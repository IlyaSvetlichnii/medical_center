module Users
  class Create
    include Interactor

    def call
      user_params = context.params

      if user_params["email"].present?
        user_params["email"] = context.profile_params["email"].downcase
      end

      user = User.create(user_params)

      if user.valid?
        context.status = :created
        context.resource = user
      else
        context.fail! status: :unprocessable_entity, errors: { user: "User not created" }
      end
    end
  end
end
