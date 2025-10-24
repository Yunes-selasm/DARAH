module V1::HubspotActions::Validations
  class Base
    def initialize(params)
      @params = params
    end

    def validate!
      raise(NotImplementedError)
    end

    private

    attr_reader :params
  end
end