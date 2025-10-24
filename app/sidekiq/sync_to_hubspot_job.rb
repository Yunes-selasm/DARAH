class SyncToHubspotJob
  include Sidekiq::Job

  sidekiq_options queue: 'sync_to_hubspot',
                  retry: false

  def perform(*payload)
    actions = HubspotAction.where(id: payload['action_ids'])
    return if actions.blank?

    V1::HubspotActions::Sync::Manager.new(actions).call
  end
end
