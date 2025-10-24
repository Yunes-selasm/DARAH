module V1::HubspotActions::Sync::Payloads
  class ConsultingService < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Deals::SimplePublicObjectInput.new(
          properties: {
            dealstage: AppConfig.deal_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            name_of_the_entity: action.body['name_of_the_entity'],
            purpose_of_the_request: action.body['purpose_of_the_request'],
            request_details: action.body['request_details'],
            file_link: action.body['file'],
            dealname: SERVICES_NAMES['consulting_services']
          }
        )
      end

      Hubspot::Crm::Deals::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
