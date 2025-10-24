module V1::HubspotClient
  class Tickets
    class << self
      def create_association(ticket_id, association_type, linked_object_id, association_type_id)
        Hubspot::Crm::Tickets::AssociationsApi.new.create(
          ticket_id,
          association_type,
          linked_object_id,
          association_type_id,
          auth_names: 'oauth2'
        )
      end

      def bulk_create(params, **options)
        Hubspot::Crm::Tickets::BatchApi.new.create(
          params,
          { auth_names: 'oauth2' }.merge(options)
        ).results
      end
    end
  end
end
