module V1::HubspotActions::BodyAttributes
  class CreateService < Base
    private

    def attributes
      case param[:body][:service_type]
      when 'publish_book'
        publish_book_attributes
      when 'publish_scientific_journal'
        publish_scientific_journal_attributes
      when 'recording_oral_histories'
        recording_oral_histories_attributes
      when 'archive_digitization'
        archive_digitization_attributes
      when 'deposit_historical_materials'
        deposit_historical_materials_attributes
      when 'access_historical_materials'
        access_historical_materials_attributes
      when 'lists_of_sources_or_references'
        lists_of_sources_or_references_attributes
      when 'consulting_services'
        consulting_services_attributes
      when 'general_inquiry'
        general_inquiry_attributes
      when 'preserving_historical_materials'
        preserving_historical_materials_attributes
      else
        handle_unknown_service_type
      end      
    end

    def publish_book_attributes
      %i[
        service_type
        author_name
        author_academic_degree
        book_title
        book_language
        number_of_volumes
        number_of_pages
        summary
        copy_of_the_book
        book_translation
        cv
      ]
    end
    
    def publish_scientific_journal_attributes
      %i[
        service_type
        journal_name
        researcher_name
        academic_title
        research_title
        language_of_the_scientific_article
        number_of_pages
        abstract_of_the_scientific_article
        scientific_article
        supporting_documents
        research_translation
        cv
      ]
    end
    
    def recording_oral_histories_attributes
      %i[
        service_type
        narrator_name
        age
        mobile_number
        email
        region
        city
        national_address
        residence_location
        coordinator_s_mobile_number
        justifications_for_service_request
        topics
        number_of_people
        recording_and_use_consent
        file
      ]
    end
    
    def archive_digitization_attributes
      %i[
        service_type
        applicant
        type_of_materials
        total_quantity_of_archives
        condition_of_materials
        brief_description_of_archives
        client_requirements
        file
        other
      ]
    end
    
    def deposit_historical_materials_attributes
      %i[
        service_type
        supply_method
        material_type
        material_ownership
        brief_description
        file
        other
      ]
    end
    
    def access_historical_materials_attributes
      %i[
          year
          issue_date
          journal_name
          issue
          service_type
          material_type
          beneficiary
          other
          record_number
          document_title
          document_date
          classification_number
          guest_name
          subject
          title
          collections
          file
          manuscript_number
          manuscript_title
          author
          copier
          page_detail
          book_title
          author_name
          date_of_publication
          article_title
          article_author
          beneficiary_type
          request_details
        ]
    end
    
    def lists_of_sources_or_references_attributes
      %i[
        service_type
        purpose_of_the_request
        request_details
        subject_of_the_request
        subject_headings
        file
        from
        to
        other
      ]
    end
    
    def consulting_services_attributes
      %i[
        service_type
        name_of_the_entity
        purpose_of_the_request
        request_details
        file
      ]
    end
    
    def general_inquiry_attributes
      %i[
        service_type
        purpose_of_the_request
        request_details
        file
      ]
    end
    
    def preserving_historical_materials_attributes
      %i[
        service_type
        material_type
        service_required
        form
        type
        material
        summary
        book_cover_image
        file
        other
      ]
    end
  end
end
