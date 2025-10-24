module V1::HubspotActions::BodyAttributes
  class Base
    def initialize(param)
      @param = param
    end

    def call
      if param[:action_type] == 'create_service' || param[:action_type] == 'create_order'
        attributes << { account: account_attributes }
      else
        attributes
      end
    end

    private

    attr_reader :param

    def attributes
      []
    end

    def account_attributes
      if param[:body][:account]['account_type'] == 'contact'
        %i[id account_type mobile_number email full_name gender]
      else
        %i[id account_type mobile_number email organization_name]
      end
    end
  end
end
