module V1::HubspotActions::Sync::Actions
  class UpdateContact < Base
    def call
      push_to_hubspot
      action.update(success_action_data)
    rescue => e
      action.update(failed_action_data)
      send_rollbar(message: 'Invalid contact update', hash: { error: e.message })
    end

    private

    attr_reader :updated_contact

    def push_to_hubspot
      return send_rollbar(message: 'Contact not exists') if contact.blank?

      @updated_contact = V1::HubspotClient::Contacts.update(contact.id, payload)
    end

    def additional_data
      {
        hubspot_action: 'Update Contact',
        hubspot_id: updated_contact.id,
        **action.body
      }
    end

    def payload
      V1::HubspotActions::Sync::Payloads::UpdateContact.new(action).call
    end

    def contact
      filters = [
        { property_name: 'contact_id', operator: 'EQ', value: action.body['id'] }
      ]

      V1::HubspotClient::Contacts.search(filters).results.first
    end

    def action
      actions.first
    end

    def success_action_data
      {
        status: 'success',
        synced_at: DateTime.current,
        metadata: {
          hubspot_record: updated_contact.as_json,
          hubspot_object_type: updated_contact.class.name,
          additional_data:
        }
      }
    end

    def failed_action_data
      { status: 'failed' }
    end
  end
end
