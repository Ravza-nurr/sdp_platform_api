class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses, id: :uuid do |t|
      t.uuid :survey_id
      t.uuid :participant_id
      t.jsonb :response_data
      t.jsonb :demographic_data
      t.datetime :completed_at
      t.string :ip_address
      t.string :device_info
      t.boolean :is_complete

      t.timestamps
    end
  end
end
