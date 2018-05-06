module Users
  class AddPatient
    include Interactor

    def call
      patient_id = context.patient_id
      current_user = context.current_user

      user = find_user(patient_id)

      if user.update_attributes(doctor_id: current_user.id)
        context.status = :ok
        context.resource = user
      else
        context.fail! status: :unprocessable_entity, errors: { user: "User not created" }
      end
    end

    private

    def find_user(user_id)
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      context.fail! status: :bad_request, errors: { email_password: "User not found"}
    end
  end
end
