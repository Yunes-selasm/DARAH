module V1::HubspotClient
  class Companies
    class << self
      def bulk_create(params)
        Hubspot::Crm::Companies::BatchApi.new.create(params, auth_names: 'oauth2')
      end

      def create(params)
        payload = Hubspot::Crm::Companies::SimplePublicObjectInput.new(properties: params)
        Hubspot::Crm::Companies::BasicApi.new.create(payload, auth_names: 'oauth2')
      end

      def bulk_update(payload)
        batch_input = Hubspot::Crm::Companies::BatchInputSimplePublicObjectBatchInput.new(inputs: payload)
        Hubspot::Crm::Companies::BatchApi.new.update(batch_input, auth_names: 'oauth2')
      end

      def update(id, params)
        payload = Hubspot::Crm::Companies::SimplePublicObjectInput.new(properties: params)
        Hubspot::Crm::Companies::BasicApi.new.update(id, payload, auth_names: 'oauth2')
      end

      def search(filters, **options)
        filter_groups = filters.map do |filter| 
          Hubspot::Crm::Companies::FilterGroup.new(filters: [Hubspot::Crm::Contacts::Filter.new(filter)])
        end
        search_request = Hubspot::Crm::Companies::PublicObjectSearchRequest.new(
          { filter_groups: }.merge(options)
        )

        Hubspot::Crm::Companies::SearchApi.new.do_search(search_request, auth_names: 'oauth2')
      end
    end
  end
end