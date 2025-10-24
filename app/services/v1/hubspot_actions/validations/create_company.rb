module V1::HubspotActions::Validations
  class CreateCompany < Base
    def validate!
      params.param!(
        :id,
        String,
        required: true,
        blank: false
      )
      params.param!(:email, String)
      params.param!(:mobile_number, String)
      params.param!(:organization_name, String)
    end
  end
end
