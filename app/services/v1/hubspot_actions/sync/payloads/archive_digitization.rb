module V1::HubspotActions::Sync::Payloads
  class ArchiveDigitization < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Deals::SimplePublicObjectInput.new(
          properties: {
            dealstage: AppConfig.deal_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            applicants: action.body['applicant'],
            material_types: action.body['type_of_materials'],
            total_quantity_of_archive: action.body['total_quantity_of_archives'],
            conditions_of_materials: action.body['condition_of_materials'],
            brief_description_of_archive: action.body['brief_description_of_archives'],
            client_requirements: action.body['client_requirements'],
            file_link: action.body['file'],
            dealname: SERVICES_NAMES['archive_digitization'],
            other: action.body['other']
          }
        )
      end

      Hubspot::Crm::Deals::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end

