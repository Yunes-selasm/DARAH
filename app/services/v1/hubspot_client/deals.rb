module V1::HubspotClient
  class Deals
    class << self
      def create_association(deal_id, association_type, linked_object_id, association_type_id)
        Hubspot::Crm::Deals::AssociationsApi.new.create(
          deal_id,
          association_type,
          linked_object_id,
          association_type_id,
          auth_names: 'oauth2'
        )
      end

      def bulk_create(params, **options)
        Hubspot::Crm::Deals::BatchApi.new.create(
          params,
          { auth_names: 'oauth2' }.merge(options)
        ).results
      end

      def search_by(filters, **options)
        filter = filters.map { |filter| Hubspot::Crm::Deals::Filter.new(filter) }
        filter_group = Hubspot::Crm::Deals::FilterGroup.new(filters: filter)
        search_params = Hubspot::Crm::Deals::PublicObjectSearchRequest.new(
          {
            filter_groups: [filter_group].flatten,
            properties: ['dealname', 'is_create', 'dealstage', 'pipeline', 'hs_object_id'],
            limit: 100
          }.merge(options)
        )

        Hubspot::Crm::Deals::SearchApi.new.do_search(search_params, auth_names: 'oauth2')
      end

      def bulk_update(batch_input)
        Hubspot::Crm::Deals::BatchApi.new.update(batch_input, auth_names: 'oauth2')
      end
    end
  end
end
