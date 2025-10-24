module V1::HubspotActions::Sync
  class Manager
    def initialize(actions)
      @actions = actions
    end

    def call
      klass_service.new(actions).call
    end

    private

    attr_reader :actions

    def klass_service
      action = actions.first
      klass_name =
        action.create_service? ? action.body['service_type'].classify : action.action_type.classify

      "V1::HubspotActions::Sync::Actions::#{klass_name}".constantize
    end
  end
end

