module V1::HubspotActions::Sync::Payloads
  class AccessHistoricalMaterial < Base
    def call
      inputs = actions.map do |action|
        method_name = action.body['material_type'].downcase.parameterize.underscore

        Hubspot::Crm::Deals::SimplePublicObjectInput.new(
          properties: properties(action).merge(
            material_types: action.body['material_type'],
            account_id: action.body['account']['id'],
            db_id: action.id,
            beneficiaries: action.body['beneficiary'],
            dealname: SERVICES_NAMES['access_historical_materials'],
            dealstage: AppConfig.deal_pipeline_stage_id,
            other: action.body['other']
          )
        )
      end

      Hubspot::Crm::Deals::BatchInputSimplePublicObjectInput.new(inputs:)
    end

    private

    def properties(action)
      {
        record_numbers: action.body['record_number'],
        document_titles: action.body['document_title'],
        documents_date: action.body['document_date'],
        subject: action.body['subject'],
        guest_name: action.body['guest_name'],
        classification_number: action.body['classification_number'],
        title: action.body['title'],
        file_link: action.body['file'],
        manuscript_number: action.body['manuscript_number'],
        manuscript_title: action.body['manuscript_title'],
        author: action.body['author'],
        copier: action.body['copier'],
        collections: action.body['collections'],
        book_title: action.body['book_title'],
        page_detail: action.body['page_detail'],
        author_name: action.body['author_name'],
        dates_of_publication: action.body['date_of_publication'],
        journal_name: action.body['journal_name'],
        article_title: action.body['article_title'],
        article_author: action.body['article_author'],
        issue: action.body['issue'],
        year: action.body['year'],
        issue_dates: action.body['issue_date'],
        beneficiary_type: action.body['beneficiary_type'],
        request_details: action.body['request_details']
      }.compact_blank
    end
    

    # def documents(action)
    #   {
    #     record_number: action.body['record_number'],
    #     document_title: action.body['document_title'],
    #     document_date: action.body['document_date']
    #   }
    # end

    # def newspapers(action)
    #   {
    #     article_title: action.body['article_title'],
    #     year: action.body['year'],
    #     issue_date: action.body['issue_date'],
    #     journal_name: action.body['journal_name'],
    #     issue: action.body['issue']
    #   }
    # end

    # def oral_histories(action)
    #   {
    #     record_number: action.body['record_number'],
    #     subject: action.body['subject'],
    #     classification_number: action.body['classification_number'],
    #     guest_name: action.body['guest_name']
    #   }
    # end

    # def films(action)
    #   {
    #     classification_number: action.body['classification_number'],
    #     title: action.body['title'],
    #     collections: action.body['collections'],
    #     file_link: action.body['file']
    #   }
    # end

    # def photos(action)
    #   {
    #     classification_number: action.body['classification_number'],
    #     title: action.body['title'],
    #     collections: action.body['collections'],
    #     file_link: action.body['file']
    #   }
    # end

    # def manuscripts(action)
    #   {
    #     manuscript_number: action.body['manuscript_number'],
    #     manuscript_title: action.body['manuscript_title'],
    #     author: action.body['author'],
    #     copier: action.body['copier'],
    #     page_detail: action.body['page_detail'],
    #     collections: action.body['collections']
    #   }
    # end

    # def books(action)
    #   {
    #     book_title: action.body['book_title'],
    #     page_detail: action.body['page_detail'],
    #     author_name: action.body['author_name'],
    #     date_of_publication: action.body['date_of_publication']
    #   }
    # end

    # def magazines(action)
    #   {
    #     journal_name: action.body['journal_name'],
    #     article_title: action.body['article_title'],
    #     article_author: action.body['article_author'],
    #     issue: action.body['issue'],
    #     year: action.body['year'],
    #     issue_date: action.body['issue_date']
    #   }
    # end
  end
end
