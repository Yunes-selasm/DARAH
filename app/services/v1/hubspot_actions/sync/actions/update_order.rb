module V1::HubspotActions::Sync::Actions
  class UpdateOrder < Base
    def push_to_hubspot
      V1::HubspotClient::Deals.bulk_update(payload)
    end

    private

    def payload
      V1::HubspotActions::Sync::Payloads::UpdateOrder.new(actions).call
    end
  end
end
