# == Schema Information
#
# Table name: hubspot_actions
#
#  id          :integer          not null, primary key
#  action_type :string           not null
#  status      :string           not null
#  body        :jsonb            not null
#  metadata    :jsonb
#  synced_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_hubspot_actions_on_action_type  (action_type)
#  index_hubspot_actions_on_status       (status)
#

class HubspotAction < ApplicationRecord
  # Includes
  include HubspotActionPresenter

  # Constants
  ACTION_TYPES = {
    create_company: 'create_company',
    update_company: 'update_company',
    create_contact: 'create_contact',
    update_contact: 'update_contact',
    create_service: 'create_service',
    create_order: 'create_order',
    update_order: 'update_order'
  }.freeze
  STATUSES = {
    pending: 'pending',
    failed: 'failed',
    success: 'success'
  }.freeze

  ransacker :id do
    Arel.sql("id::text")
  end

  ransacker :created_at_date, type: :date do
    Arel.sql("DATE(created_at)")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["action_type", "id", "status", "created_at_date"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  # Enums
  enum :action_type, ACTION_TYPES, validate: true
  enum :status, STATUSES, validate: true

  # Validations
  validates :action_type, :status, presence: true

  # Callbacks
  before_validation :init, on: :create
  # after_create_commit :sync_to_hubspot

  def updated?
    created_minute = created_at.change(sec: 0)
    updated_minute = updated_at.change(sec: 0)
    created_minute != updated_minute
  end

  private

  def init
    self.status = :pending
  end

  # def sync_to_hubspot
    # if (ENV['SIDEKIQ_ENABLED'] || Rails.application.credentials[:sidekiq_enabled])
    #   SyncActionToHubspotJob.perform_later(action_ids: self.id)
    # # else
    #   klass_name = action_type.classify
    #   klass_service = "V1::HubspotActions::Hubspot::#{klass_name}".constantize
    #   klass_service.new(self).sync
    # # end
  # end
end
