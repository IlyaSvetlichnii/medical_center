class Api::V1::UsersController < Api::V1::BaseController

  skip_before_action :authenticate!, only: [:create]

  # Show individual profile info
  def show
    result = Individuals::Show.call(individual_id: params[:id], current_profile: current_profile)

    render resource_render_params(
      result,
      serializer: ::V1::Individuals::IndividualSerializer
    )
  end

  def create
    result = Users::Register.call(profile_params: profile_params)
    render resource_render_params(result, serializer: ::V1::UserSerializer)
  end

  def upload_avatar
    result = Individuals::UploadAvatar.call(
      caller_profile: current_profile,
      avatar: params[:avatar]
    )

    render resource_render_params(
      result,
      serializer: ::V1::Individuals::IndividualSerializer
    )
  end

  def destroy_avatar
    result = Individuals::DestroyAvatar.call(
      caller_profile: current_profile,
      caller_company: current_company
    )

    render resource_render_params(
      result,
      serializer: ::V1::Individuals::IndividualSerializer
    )
  end

  private

  def profile_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :patronymic, :birthday)
  end
end
