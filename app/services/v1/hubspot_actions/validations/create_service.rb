module V1::HubspotActions::Validations
  class CreateService < Base
    SERVICES_TYPES = %w[
      publish_book
      publish_scientific_journal
      recording_oral_histories
      archive_digitization
      deposit_historical_materials
      access_historical_materials
      lists_of_sources_or_references
      consulting_services
      general_inquiry
      preserving_historical_materials
    ].freeze

    def validate!
      params.param!(:service_type, String, in: SERVICES_TYPES)
      service_type = params.params[:service_type]

      case service_type
      when 'publish_book'
        validate_publish_book!
      when 'publish_scientific_journal'
        validate_publish_scientific_journal!
      when 'recording_oral_histories'
        validate_recording_oral_histories!
      when 'archive_digitization'
        validate_archive_digitization!
      when 'deposit_historical_materials'
        validate_deposit_historical_materials!
      when 'access_historical_materials'
        validate_access_historical_materials!
      when 'lists_of_sources_or_references'
        validate_lists_of_sources_or_references!
      when 'consulting_services'
        validate_consulting_services!
      when 'general_inquiry'
        validate_general_inquiry!
      when 'preserving_historical_materials'
        validate_preserving_historical_materials!
      end

      validate_account!
    end

    private

    def validate_account!
      params.param!(:account, Hash, blank: false, required: true) do |hash|
        hash.param!(:account_type, String, blank: false, required: true, in: %w[company contact])
        hash.param!(:id, String, blank: false, required: true)
        hash.param!(:mobile_number, String)
        hash.param!(:email, String)
        hash.param!(:email, String)


        if hash.params[:account_type] == 'company'
          hash.param!(:organization_name, String)
        else
          hash.param!(:full_name, String)
          hash.param!(:gender, String)
        end
      end
    end

    def validate_publish_book!
      params.param!(:author_name, String)
      params.param!(:author_academic_degree, String)
      params.param!(:book_title, String)
      params.param!(:book_language, String)
      params.param!(:number_of_volumes, String)
      params.param!(:number_of_pages, String)
      params.param!(:summary, String)
      params.param!(:copy_of_the_book, String)
      params.param!(:book_translation, String)
      params.param!(:cv, String)
    end

    def validate_publish_scientific_journal!
      params.param!(:journal_name, String)
      params.param!(:researcher_name, String)
      params.param!(:academic_title, String)
      params.param!(:research_title, String)
      params.param!(:language_of_the_scientific_article, String)
      params.param!(:number_of_pages, String)
      params.param!(:abstract_of_the_scientific_article, String)
      params.param!(:scientific_article, String)
      params.param!(:supporting_documents, String)
      params.param!(:research_translation, String)
      params.param!(:cv, String)
    end

    def validate_recording_oral_histories!
      params.param!(:narrator_name, String)
      params.param!(:age, String)
      params.param!(:mobile_number, String)
      params.param!(:email, String)
      params.param!(:email, String)
      params.param!(:region, String)
      params.param!(:city, String)
      params.param!(:national_address, String)
      params.param!(:residence_location, String)
      params.param!(:coordinator_s_mobile_number, String)
      params.param!(:topics, String)
      params.param!(:number_of_people, String)
      params.param!(:recording_and_use_consent, String)
      params.param!(:justifications_for_service_request, String)
      params.param!(:file, String)
    end

    def validate_archive_digitization!
      params.param!(:applicant, String)
      params.param!(:type_of_materials, String)
      params.param!(:total_quantity_of_archives, String)
      params.param!(:condition_of_materials, String)
      params.param!(:brief_description_of_archives, String)
      params.param!(:client_requirements, String)
      params.param!(:file, String)
    end

    def validate_deposit_historical_materials!
      params.param!(:supply_method, String)
      params.param!(:material_type, String,)
      params.param!(:material_ownership, String)
      params.param!(:brief_description, String)
      params.param!(:file, String)
    end

    def validate_access_historical_materials!
      params.param!(:material_type, String)
      params.param!(:beneficiary, String)
      params.param!(:beneficiary_type, String)
      params.param!(:request_details, String)

      if params.params[:material_type] == 'Books'
        params.param!(:book_title, String)
        params.param!(:page_detail, String)
        params.param!(:author_name, String)
        params.param!(:date_of_publication, String)
      end

      if params.params[:material_type] == 'Documents'
        params.param!(:record_number, String)
        params.param!(:document_title, String)
        params.param!(:document_date, String)
      end

      if params.params[:material_type] == 'Films' || params.params[:material_type] == 'Photos'
        params.param!(:classification_number, String)
        params.param!(:title, String)
        params.param!(:collections, String)
        params.param!(:file, String)
      end

      if params.params[:material_type] == 'Manuscripts'
        params.param!(:manuscript_number, String)
        params.param!(:manuscript_title, String)
        params.param!(:author, String)
        params.param!(:copier, String)
        params.param!(:page_detail, String)
        params.param!(:collections, String)
      end

      if params.params[:material_type] == 'Magazines'
        params.param!(:journal_name, String)
        params.param!(:article_title, String)
        params.param!(:article_author, String)
        params.param!(:issue, String)
        params.param!(:year, String)
        params.param!(:issue_date, String)
      end

      if params.params[:material_type] == 'Oral histories'
        params.param!(:record_number, String)
        params.param!(:subject, String)
        params.param!(:classification_number, String)
        params.param!(:guest_name, String)
      end

      if params.params[:material_type] == 'Newspapers'
        params.param!(:article_title, String)
        params.param!(:year, String)
        params.param!(:issue_date, String)
        params.param!(:journal_name, String)
        params.param!(:issue, String)
      end
    end

    def validate_lists_of_sources_or_references!
      params.param!(:purpose_of_the_request, String)
      params.param!(:request_details, String)
      params.param!(:subject_of_the_request, String)
      params.param!(:subject_headings, String)
      params.param!(:from, String)
      params.param!(:to, String)
      params.param!(:file, String)
    end

    def validate_consulting_services!
      params.param!(:name_of_the_entity, String)
      params.param!(:purpose_of_the_request, String)
      params.param!(:request_details, String)
      params.param!(:file, String)
    end

    def validate_general_inquiry!
      params.param!(:purpose_of_the_request, String)
      params.param!(:request_details, String)
      params.param!(:file, String)
    end

    def validate_preserving_historical_materials!
      params.param!(:material_type, String)
      params.param!(:service_required, String)
      params.param!(:form, String)
      params.param!(:type, String)
      params.param!(:material, String)
      params.param!(:summary, String)
      params.param!(:book_cover_image, String)
      params.param!(:file, String)
    end
  end
end
