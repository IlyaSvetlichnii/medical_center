require "rails_helper"

describe "create a session" do
  subject { post '/api/login', params: auth_params, headers: headers_for_anonymous }

  let!(:signing_profile) { create :user, password: 'QQ123!!111'}
  let(:auth_params) {{ email: signing_profile.email.upcase, password: 'QQ123!!111' }}

  context "when uppercase email is given" do
    it { should eq(201) }
  end

  # context 'when user is unconfirmed' do
  #   let!(:signing_profile) { create :user, password: 'QQ123!!111' }

  #   it 'should fails with error message' do
  #     expect(subject).to eq(422)
  #     json = JSON.parse(response.body)
  #     expect(json['errors'][0]['detail']).to match('Please, confirm your account by email')
  #   end
  # end
end
