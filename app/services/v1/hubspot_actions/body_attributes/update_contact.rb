module V1::HubspotActions::BodyAttributes
  class UpdateContact < Base
    private

    def attributes
      %i[id mobile_number email full_name gender]
    end
  end
end
