module V1::HubspotActions::Sync::Actions
  class CreateOrder < Base
    def push_to_hubspot
      if actions.first.updated?
        update_or_create_deals
      else
        create_and_assign_deals
      end
    end

    private

    def update_or_create_deals
      if update_payload.present?
        @deals = update_deals.results
      else
        create_and_assign_deals
      end
    end

    def payload
      V1::HubspotActions::Sync::Payloads::CreateOrder.new(actions).call
    end

    def update_payload
      @update_payload ||= V1::HubspotActions::Sync::Payloads::UpdateOrder.new(actions).call
    end

    def update_deals
      V1::HubspotClient::Deals.bulk_update(update_payload)
    end

    def success_action_data
      actions.map do |action|
        db_ids = action['body']['order_products'].map {|op| op['id'].to_s }

        hubspot_record_ids =
          (@deals || created_deals).find_all { |record| record.properties['db_id'].in?(db_ids) }.map(&:id)

        {
          id: action.id,
          status: 'success',
          action_type: action.action_type,
          body: action.body,
          synced_at: DateTime.current,
          metadata: {
            actions_batch_ids: actions.ids,
            additional_data: additional_data(action, hubspot_record_ids)
          },
        }
      end
    end

    def additional_data(action, hubspot_record_ids)
      {
        hubspot_action: 'Create Deal',
        hubspot_record_ids: hubspot_record_ids,
        **action.body
      }
    end
  end
end
