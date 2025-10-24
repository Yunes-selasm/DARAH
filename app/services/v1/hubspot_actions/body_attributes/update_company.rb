module V1::HubspotActions::BodyAttributes
  class UpdateCompany < Base
    private

    def attributes
      %i[id mobile_number email organization_name]
    end
  end
end
