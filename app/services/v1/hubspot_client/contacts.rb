module V1::HubspotClient
  class Contacts
    class << self
      def bulk_create(params)
        Hubspot::Crm::Contacts::BatchApi.new.create(params, auth_names: 'oauth2')
      end

      def create(params)
        payload = Hubspot::Crm::Contacts::SimplePublicObjectInput.new(properties: params)
        Hubspot::Crm::Contacts::BasicApi.new.create(payload, auth_names: 'oauth2')
      end

      def update(id, params)
        payload = Hubspot::Crm::Contacts::SimplePublicObjectInput.new(properties: params)
        Hubspot::Crm::Contacts::BasicApi.new.update(id, payload, auth_names: 'oauth2')
      end

      def bulk_update(payload)
        batch_input = Hubspot::Crm::Contacts::BatchInputSimplePublicObjectBatchInput.new(inputs: payload)
        Hubspot::Crm::Contacts::BatchApi.new.update(batch_input, auth_names: 'oauth2')
      end

      def search(filters, **options)
        filter_groups = filters.map do |filter| 
          Hubspot::Crm::Contacts::FilterGroup.new(filters: [Hubspot::Crm::Contacts::Filter.new(filter)])
        end
        search_request = Hubspot::Crm::Contacts::PublicObjectSearchRequest.new(
          { filter_groups: }.merge(options)
        )

        Hubspot::Crm::Contacts::SearchApi.new.do_search(search_request, auth_names: 'oauth2')
      end
    end
  end
end