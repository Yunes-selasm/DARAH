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

require "test_helper"

class HubspotActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
