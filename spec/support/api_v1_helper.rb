module ApiV1Helper
  def fixture(name)
    File.read("spec/fixtures/#{name}")
  end

  def auth_header_value session
    ActionController::HttpAuthentication::Token.encode_credentials(
      session.raw_token,
      session: session.id
    )
  end

  def headers
    {
      "Authorization" => auth_header_value(current_session),
      "Accept" => "application/vnd.medicalCenter.v1",
    }
  end

  def headers_for session
    {
      "Authorization" => auth_header_value(session, company, company_relation: company_relation),
      "Accept" => "application/vnd.medicalCenter.v1",
    }
  end

  def headers_for_anonymous
    {
      "Accept" => "application/vnd.medicalCenter.v1",
    }
  end
end

module ApiClassHelper
  def admin_session
    let(:current_session) { create :session, individual: current_individual }
    let(:current_company) { create :company }
    let(:current_company_relation) { create_admin_for current_company }
    let(:current_individual) { current_company_relation.individual }
  end
end
