module V1::HubspotActions::Sync::Actions
  class ConsultingService < Base
    def push_to_hubspot
      create_and_assign_deals
    end

    private

    def payload
      V1::HubspotActions::Sync::Payloads::ConsultingService.new(actions).call
    end
  end
end