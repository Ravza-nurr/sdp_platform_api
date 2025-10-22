class CreateScales < ActiveRecord::Migration[8.0]
  def change
    create_table :scales, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :doi_identifier
      t.string :version
      t.string :language
      t.string :category
      t.integer :total_items
      t.uuid :creator_id
      t.integer :status
      t.jsonb :metadata
      t.integer :usage_count

      t.timestamps
    end
  end
end
