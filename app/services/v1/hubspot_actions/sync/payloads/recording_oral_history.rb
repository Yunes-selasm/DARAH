module V1::HubspotActions::Sync::Payloads
  class RecordingOralHistory < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage: AppConfig.ticket_pipeline_stage_id, 
            account_id: action.body['account']['id'],
            db_id: action.id,
            narrator_name: action.body['narrator_name'],
            ages: action.body['age'],
            mobiles_number: action.body['mobile_number'],
            email: action.body['email'],
            region: action.body['region'],
            city: action.body['city'],
            national_address: action.body['national_address'],
            residence_location: action.body['residence_location'],
            coordinator_mobile_number: action.body['coordinator_s_mobile_number'],
            justification_for_service_request: action.body['justifications_for_service_request'],
            topic: action.body['topics'],
            numbers_of_people: action.body['number_of_people'],
            recording_and_use_consents: action.body['recording_and_use_consent'].capitalize,
            file_link: action.body['file'],
            subject: SERVICES_NAMES['recording_oral_histories']
          }
        )
      end

      Hubspot::Crm::Tickets::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end

