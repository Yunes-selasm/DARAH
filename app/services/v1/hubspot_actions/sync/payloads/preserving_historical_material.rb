module V1::HubspotActions::Sync::Payloads
  class PreservingHistoricalMaterial < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Deals::SimplePublicObjectInput.new(
          properties: {
            dealstage: AppConfig.deal_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: action.id,
            material_types: action.body['material_type'],
            services_require: action.body['service_required'],
            formats: action.body['form'],
            requests_types: action.body['type'],
            raws_materials: action.body['material'],
            summaries: action.body['summary'],
            book_cover_image: action.body['book_cover_image'],
            file_link: action.body['file'],
            dealname: SERVICES_NAMES['preserving_historical_materials'],
            other: action.body['other']
          }
        )
      end

      Hubspot::Crm::Deals::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
