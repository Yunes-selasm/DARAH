# frozen_string_literal: true

class AppConfig
  class << self
    def api_accessor
      ENV['API-ACCESS-KEY']
    end

    def hubspot_access_token
      ENV['HUBSPOT_ACCESS_TOKEN']
    end

    def ticket_pipeline_stage_id
      ENV['TICKET_PIPELINE_STAGE_ID']
    end

    def deal_pipeline_stage_id
      ENV['DEAL_PIPELINE_STAGE_ID']
    end
  end
end
