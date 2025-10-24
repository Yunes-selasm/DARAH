module V1::HubspotActions::Validations
  class CreateContact < Base
    def validate!
      params.param!(
        :id,
        String,
        required: true,
        blank: false
      )
      params.param!(:email, String)
      params.param!(:mobile_number, String)
      params.param!(:full_name, String)
      params.param!(:gender, String)
    end
  end
end
