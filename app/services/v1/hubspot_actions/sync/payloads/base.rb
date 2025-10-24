module V1::HubspotActions::Sync::Payloads
  class Base
    SERVICES_NAMES = {
      'publish_book' => 'نشر كتاب',
      'publish_scientific_journal' => 'نشر في مجلة علمية',
      'recording_oral_histories' => 'تسجيل روايات شفوية',
      'deposit_historical_materials' => 'إيداع مواد تاريخية',
      'lists_of_sources_or_references' => 'قوائم المصادر أو المراجع',
      'general_inquiry' => 'استفسار عام',
      'archive_digitization' => 'رقمنة ارشيف',
      'access_historical_materials' => 'الحصول على مواد تاريخية',
      'consulting_services' => 'خدمات استشارية',
      'create_order' => 'شراء منتج',
      'preserving_historical_materials' => 'المحافظة على المواد التاريخية'
    }.freeze

    def initialize(actions)
      @actions = actions
    end

    def call
      raise(NotImplementedError)
    end
    
    private

    attr_reader :actions
  end
end
