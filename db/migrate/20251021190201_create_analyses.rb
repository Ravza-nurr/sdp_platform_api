class CreateAnalyses < ActiveRecord::Migration[8.0]
  def change
    create_table :analyses, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :survey_id
      t.integer :analysis_type
      t.jsonb :parameters
      t.jsonb :results
      t.integer :status
      t.integer :credit_cost
      t.text :r_script
      t.string :output_file
      t.text :error_message

      t.timestamps
    end
  end
end
