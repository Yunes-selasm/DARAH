module V1::HubspotActions::Sync::Actions
  class CreateCompany < Base
    def call
      push_to_hubspot
      action.update(success_action_data)
    rescue => e
      action.update(failed_action_data)
      send_rollbar(message: 'Invalid company creation', hash: { error: e.message })
    end

    private

    attr_reader :created_company

    def push_to_hubspot
      @created_company = V1::HubspotClient::Companies.create(payload)
    end

    def additional_data
      {
        hubspot_action: 'Create Company',
        hubspot_id: created_company.id,
        **action.body
      }
    end

    def payload
      V1::HubspotActions::Sync::Payloads::CreateCompany.new(action).call
    end

    def success_action_data
      {
        status: 'success',
        synced_at: DateTime.current,
        metadata: {
          hubspot_record: created_company.as_json,
          hubspot_object_type: created_company.class.name,
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
