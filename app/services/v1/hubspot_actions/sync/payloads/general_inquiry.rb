module V1::HubspotActions::Sync::Payloads
  class GeneralInquiry < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage: AppConfig.ticket_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            purpose_of_the_requests: action.body['purpose_of_the_request'],
            requests_details: action.body['request_details'],
            file_link: action.body['file'],
            subject: SERVICES_NAMES['general_inquiry']
          }
        )
      end

      Hubspot::Crm::Tickets::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
