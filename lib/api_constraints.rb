class ApiConstraints
  def initialize(version: nil)
    @version = version
  end

  def matches?(req)
    req.headers['Accept'] && (req.headers['Accept'].include?("application/vnd.medicalCenter.v#{@version}"))
  end
end
