module V1::HubspotActions::Sync::Actions
  class CreateContact < Base
    def call
      push_to_hubspot
      action.update(success_action_data)
    rescue => e
      action.update(failed_action_data)
      send_rollbar(message: 'Invalid contact creation', hash: { error: e.message })
    end

    private

    attr_reader :created_contact

    def push_to_hubspot
      @created_contact =  V1::HubspotClient::Contacts.create(payload)
    end

    def additional_data
      {
        hubspot_action: 'Create Contact',
        hubspot_id: created_contact.id,
        **action.body
      }
    end

    def payload
      V1::HubspotActions::Sync::Payloads::CreateContact.new(action).call
    end

    def success_action_data
      {
        status: 'success',
        synced_at: DateTime.current,
        metadata: {
          hubspot_record: created_contact.as_json,
          hubspot_object_type: created_contact.class.name,
          additional_data:
        }
      }
    end

    def failed_action_data
      { status: 'failed' }
    end

    def action
      actions.first
    end
  end
end
