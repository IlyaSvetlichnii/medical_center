module Sessions
  class Create
    include Interactor

    def call
      if context.email.nil? || context.password.nil?
        context.fail! status: :bad_request, errors: { email_or_password: "Please, enter both email and password" }
      end

      email = context.email.downcase
      user = User.find_by(email: email).try(:authenticate, context.password)

      if user
        sess = user.sessions.create
        context.resource = sess
        context.status = :created
      else
        context.fail! status: :bad_request, errors: { email_password: "The email and password that you entered don't match"}
      end
    end
  end
end
