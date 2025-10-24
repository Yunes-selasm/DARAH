module V1::HubspotActions::Sync::Payloads
  class UpdateContact < Base
    def initialize(action)
      @action = action
    end

    def call
      gender_list = action.body['gender']

      {
        email: action.body['email'],
        full_name: action.body['full_name'],
        genders_list: gender_list.nil? ? 'notdefined' : gender_list.capitalize,
        mobile_number: action.body['mobile_number']
      }
    end

    private

    attr_reader :action
  end
end
