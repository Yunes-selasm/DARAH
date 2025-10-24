module V1::HubspotActions::Sync::Payloads
  class DepositHistoricalMaterial < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage: AppConfig.ticket_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            supply_methods: action.body['supply_method'],
            material_types: action.body['material_type'],
            material_ownerships: action.body['material_ownership'],
            brief_description: action.body['brief_description'],
            file_link: action.body['file'],
            other: action.body['other'],
            subject: SERVICES_NAMES['deposit_historical_materials']
          }
        )
      end

      Hubspot::Crm::Tickets::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
