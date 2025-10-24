module V1::HubspotActions::Sync::Actions
  class PreservingHistoricalMaterial < Base
    def push_to_hubspot
      create_and_assign_deals
    end

    private

    def payload
      V1::HubspotActions::Sync::Payloads::PreservingHistoricalMaterial.new(actions).call
    end
  end
end