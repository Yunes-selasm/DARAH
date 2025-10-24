class CreateHubspotActions < ActiveRecord::Migration[8.0]
  def change
    create_table(:hubspot_actions) do |t|
      t.string(:action_type, null: false, index: true)
      t.string(:status, null: false, index: true)
      t.jsonb(:body, null: false)
      t.jsonb(:metadata)
      t.datetime(:synced_at)

      t.timestamps
    end
  end
end
