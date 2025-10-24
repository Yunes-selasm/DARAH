module V1::HubspotActions::Sync::Payloads
  class PublishScientificJournal < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage: AppConfig.ticket_pipeline_stage_id, 
            account_id: action.body['account']['id'],
            db_id: action.id,
            journals_name: action.body['journal_name'],
            researcher_name: action.body['researcher_name'],
            academic_title: action.body['academic_title'],
            research_title: action.body['research_title'],
            languages_of_the_scientific_article: action.body['language_of_the_scientific_article'],
            numbers_of_pages: action.body['number_of_pages'],
            abstract_of_the_scientific_article: action.body['abstract_of_the_scientific_article'],
            scientific_article: action.body['scientific_article'],
            supporting_documents: action.body['supporting_documents'],
            research_translation: action.body['research_translation'],
            cv: action.body['cv'],
            subject: SERVICES_NAMES['publish_scientific_journal']
          }
        )
      end

      Hubspot::Crm::Companies::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
