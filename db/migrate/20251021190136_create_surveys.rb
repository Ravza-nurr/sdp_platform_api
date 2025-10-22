class CreateSurveys < ActiveRecord::Migration[8.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :title
      t.text :description
      t.uuid :scale_id
      t.uuid :user_id
      t.integer :status
      t.integer :distribution_mode
      t.datetime :start_date
      t.datetime :end_date
      t.integer :response_count
      t.integer :target_responses
      t.jsonb :settings

      t.timestamps
    end
  end
end
