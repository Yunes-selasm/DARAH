module V1::HubspotActions::Sync::Actions
  class UpdateCompany < Base
    def call
      push_to_hubspot
      action.update(success_action_data)
    rescue => e
      action.update(failed_action_data)
      send_rollbar(message: 'Invalid company update', hash: { error: e.message })
    end

    private

    attr_reader :updated_company

    def push_to_hubspot
      return send_rollbar(message: 'Company not exists') if company.blank?

      @updated_company = V1::HubspotClient::Companies.update(company.id, payload)
    end

    def additional_data
      {
        hubspot_action: 'Update Company',
        hubspot_id: updated_company.id,
        **action.body
      }
    end

    def payload
      V1::HubspotActions::Sync::Payloads::UpdateCompany.new(action).call
    end

    def company
      filters = [
        { property_name: 'company_id', operator: 'EQ', value: action.body['id'] }
      ]

      V1::HubspotClient::Companies.search(filters).results.first
    end

    def action
      actions.first
    end

    def success_action_data
      {
        status: 'success',
        synced_at: DateTime.current,
        metadata: {
          hubspot_record: updated_company.as_json,
          hubspot_object_type: updated_company.class.name,
          additional_data:
        }
      }
    end

    def failed_action_data
      { status: 'failed' }
    end
  end
end
