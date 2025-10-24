module V1::HubspotActions::Sync::Actions
  class DepositHistoricalMaterial < Base
    def push_to_hubspot
      create_and_assign_tickets
    end

    private

    def payload
      V1::HubspotActions::Sync::Payloads::DepositHistoricalMaterial.new(actions).call
    end
  end
end