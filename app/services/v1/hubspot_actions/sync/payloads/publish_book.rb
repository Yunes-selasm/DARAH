module V1::HubspotActions::Sync::Payloads
  class PublishBook < Base
    def call
      inputs = actions.map do |action|
        Hubspot::Crm::Tickets::SimplePublicObjectInput.new(
          properties: {
            hs_pipeline_stage:  AppConfig.ticket_pipeline_stage_id,  
            account_id: action.body['account']['id'],
            db_id: action.id,
            author_name: action.body['author_name'],
            author_academic_degree: action.body['author_academic_degree'],
            book_title: action.body['book_title'],
            books_language: action.body['book_language'],
            numbers_of_volumes: action.body['number_of_volumes'],
            numbers_of_pages: action.body['number_of_pages'],
            summaries: action.body['summary'],
            copy_of_the_book: action.body['copy_of_the_book'],
            book_translation: action.body['book_translation'],
            cv: action.body['cv'],
            subject: SERVICES_NAMES['publish_book']
          }
        )
      end

      Hubspot::Crm::Tickets::BatchInputSimplePublicObjectInput.new(inputs:)
    end
  end
end
