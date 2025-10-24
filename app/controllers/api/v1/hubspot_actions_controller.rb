module Api::V1
  class HubspotActionsController < Api::V1::BaseController
    # POST /api/v1/hubspot_actions
    def create
      actions = V1::HubspotActions::Create.new(create_params: params_processed).call
      # actions = HubspotAction.insert_all(params_processed, returning: [:id, :action_type, :body])

      # actions.each do |action|
      #   action[:body] = JSON.parse(action['body'])
      # end

      # actions.pluck('id').each_slice(10) do |ids|
      #   SyncActionToHubspotJob.perform_later(action_ids: ids)
      # end

      # actions = HubspotAction.where(id: actions.pluck('id'))
      # V1::HubspotActions::Sync::Manager.new(actions).call

      render_created(data: actions, message: 'Synced successfully')
    end

    private

    def hubspot_action_params
       params[:hubspot_action].map do |param|
        action_type = param[:action_type].classify

        service_klass = "V1::HubspotActions::BodyAttributes::#{action_type}".constantize
        attributes = service_klass.new(param).call

        body_attributes =
          if action_type.in?(['CreateOrder', 'UpdateOrder'])
            param[:body]
          else
            param[:body].permit(*attributes)
          end

        param.slice(:action_type, :status).merge(body: body_attributes.merge(is_added_by_darah: param[:added_by_darah].presence || true))
      end
    end

    def validate_create_params!
      param!(:hubspot_action, Array, blank: false, required: true) do |hash|
        action_type = hash.params[:action_type].classify

        hash.param!(:action_type, String, required: true, blank: false, in: HubspotAction.action_types.keys)
        hash.param!(:status, String, default: 'pending')
        hash.param!(:body, Hash, required: true, blank: false) do |h|
          validate_klass = "V1::HubspotActions::Validations::#{action_type}".constantize
          validate_klass.new(h).validate!
        end
      end
    end
  end
end
