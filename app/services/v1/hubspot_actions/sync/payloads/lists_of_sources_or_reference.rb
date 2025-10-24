module V1::HubspotActions::Sync::Payloads
  class ListsOfSourcesOrReference < Base
    def call 
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage: AppConfig.ticket_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            purpose_of_the_requests: action.body['purpose_of_the_request'],
            requests_details: action.body['request_details'],
            subject_of_the_request: action.body['subject_of_the_request'],
            subject_headings: action.body['subject_headings'],
            from: action.body['from'],
            to: action.body['to'],
            file_link: action.body['file'],
            subject: SERVICES_NAMES['lists_of_sources_or_references'],
            other: action.body['other']
          }
        )
      end

      Hubspot::Crm::Tickets::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
