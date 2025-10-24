module V1::HubspotActions::Sync::Actions
  class Base
    def initialize(actions)
      @actions = actions
    end

    def call
      push_to_hubspot
      update_actions(success_action_data)
    rescue => e
      update_actions(failed_action_data)
      send_rollbar(message: e.message, hash: { error: e.message })
    end

    private

    attr_reader :actions

    def create_and_assign_tickets
      raise(ValidationFailed, 'Account not found when create ticket') if hubspot_account_id.blank?

      created_tickets.each do |ticket|
        association_type = account_type == 'contact' ? 'contacts' : 'companies'
        association_type_id = account_type == 'contact' ? 16 : 26

        V1::HubspotClient::Tickets.create_association(
          ticket.id, association_type, hubspot_account_id, association_type_id
        )
      end
    end

    def failed_action_data
      actions.map do |action|
        {
          id: action.id,
          status: 'failed',
          action_type: action.action_type,
          body: action.body,
          metadata: { actions_batch_ids: actions.ids }
        }
      end
    end

    def success_action_data
      records =
        instance_variable_defined?(:@created_tickets) ? created_tickets : created_deals

      actions.map do |action|
        hubspot_record = records.find { |record| record.properties['db_id'] == action.id.to_s }

        {
          id: action.id,
          status: 'success',
          action_type: action.action_type,
          body: action.body,
          synced_at: DateTime.current,
          metadata: {
            actions_batch_ids: actions.ids,
            hubspot_record: hubspot_record.as_json,
            hubspot_object_type: hubspot_record.class.name,
            additional_data: additional_data(action, hubspot_record)
          },
        }
      end
    end

    def additional_data(action, hubspot_record)
      {
        hubspot_action: instance_variable_defined?(:@created_tickets) ? 'Create Ticket' : 'Create Deal',
        hubspot_id: hubspot_record.id,
        **action.body
      }
    end

    def update_actions(data)
      actions.upsert_all(data, update_only: [:status, :synced_at, :metadata])
    end

    def create_and_assign_deals
      created_deals.each do |deal|
        raise(ValidationFailed, 'Account not found when create deal') if hubspot_account_id.blank?

        association_type = account_type == 'contact' ? 'contacts' : 'companies'
        association_type_id = account_type == 'contact' ? 3 : 5

        V1::HubspotClient::Deals.create_association(
          deal.id, association_type, hubspot_account_id, association_type_id
        )
      end
    end

    def send_rollbar(message:, hash: {})
      Rollbar.error(message, custom: hash.merge(actions: actions.as_json))
    end

    def account_type
      account['account_type']
    end

    def created_tickets
      @created_tickets ||=
        V1::HubspotClient::Tickets.bulk_create(payload, properties: [:account_id, :db_id])
    end

    def created_deals
      return [] if payload.blank?

      @created_deals ||= V1::HubspotClient::Deals.bulk_create(payload, properties: [:account_id, :db_id])
    end

    def account
      actions.first.body['account']
    end

    def hubspot_account_id
      if account_type == 'contact'
        find_contact
      else
        find_company
      end&.id
    end

    def find_contact
      return @contact if instance_variable_defined?(:@contact) 

      filters = [
        { property_name: 'contact_id', operator: 'EQ', value: account['id'] }
      ]

      @contact = V1::HubspotClient::Contacts.search(filters).results.first
    end

    def find_company
      return @company if instance_variable_defined?(:@company) 

      filters = [
        { property_name: 'company_id', operator: 'EQ', value: account['id'] }
      ]

      @company = V1::HubspotClient::Companies.search(filters).results.first
    end
  end
end