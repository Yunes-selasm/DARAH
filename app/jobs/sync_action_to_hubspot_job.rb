class SyncActionToHubspotJob < ApplicationJob
  queue_as :default

  def perform(*args)
    payload = args.first.with_indifferent_access
    actions = HubspotAction.where(id: payload['action_ids'])
    return if actions.blank?

    V1::HubspotActions::Sync::Manager.new(actions).call
  end
end
