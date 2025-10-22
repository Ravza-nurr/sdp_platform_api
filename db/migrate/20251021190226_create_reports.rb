class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports, id: :uuid do |t|
      t.uuid :analysis_id
      t.uuid :user_id
      t.integer :format
      t.text :content
      t.string :file_path
      t.integer :status

      t.timestamps
    end
  end
end
