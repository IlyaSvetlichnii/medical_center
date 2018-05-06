class UsersController < ApplicationController
  before_action :authorize, only: [:add_patient, :patients, :index, :patient_registration]

  def index
    @patients = User.where(doctor_id: current_user.id)
  end

  def create
    result = Users::Create.call(params: user_params)

    if result.success?
      redirect_to login_path
    else
      flash.now[:message] = t(result.message)
      render :new
    end
  end

  def patient_registration

  end

  def patients
    @patients = User.where(position: :patient)
  end

  def add_patient
    result = Users::AddPatient.call(
      patient_id: params[:patient_id],
      current_user: current_user
    )

    if result.success?
      redirect_to patients_path
    else
      flash.now[:message] = t(result.message)
      redirect_to patients_path
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :patronymic, :birthday)
  end
end
