require "rails_helper"

describe "signup" do
  subject { post "/api/signup", params: params, headers: headers_for_anonymous }

  admin_session

  let(:params) do
    {
      email: "iliya@gmail.com",
      password: 'QQ123!!111',
      password_confirmation: 'QQ123!!111'
    }
  end

  it "should create new unconfirmed individual" do
    expect(subject).to eq(201)

    json = JSON.parse(response.body)
    # expect(json['success_message'][0]['title']).to match("User was successfully registered.")
  end

  # context "when email has uppercase letters" do
  #   let(:email) { "KALYS@OSMONOV.com" }

  #   it "should create user with downcased email" do
  #     expect(subject).to eq(201)

  #     user = User.first
  #     expect(user.email).to eq("kalys@osmonov.com")
  #   end
  # end
end
