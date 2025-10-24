module V1::HubspotActions::Sync::Payloads
  class UpdateCompany < Base
    def initialize(action)
      @action = action
    end

    def call
      {
        name: action.body['organization_name'],
        company_email: action.body['email'],
        mobile_number: action.body['mobile_number']
      }
    end

    private

    attr_reader :action
  end
end
