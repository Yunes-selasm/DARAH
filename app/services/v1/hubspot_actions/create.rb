module V1::HubspotActions
  class Create
    def initialize(create_params:)
      @create_params = create_params.as_json
    end

    def call
      create_params.each do |param|
        action =
          if create_order?
            manage_order(param)
          else
            create_action(param)
          end

        SyncActionToHubspotJob.perform_later(action_ids: [action.id])
      end
    end

    private

    attr_reader :create_params

    def manage_order(param)
      order = HubspotAction.create_order.find_by("body ->> 'id' = ?", param['body']['id'])

      if order.present?
        order.update!(param)
        order
      else
        create_action(param)
      end
    end

    def create_action(param)
      HubspotAction.create!(param)
    end

    def create_order?
      create_params.first['action_type'] == 'create_order'
    end
  end
end
