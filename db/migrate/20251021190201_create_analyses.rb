class CreateAnalyses < ActiveRecord::Migration[8.0]
  def change
    # PostgreSQL'de UUID kullanımını etkinleştirir
    enable_extension 'uuid-ossp'

    create_table :analyses, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :survey_id
      
      # ENUM DEĞERLERİ İÇİN DÜZELTME: default ve null kısıtlamaları eklendi
      t.integer :analysis_type, default: 0, null: false
      
      t.jsonb :parameters
      t.jsonb :results
      
      # ENUM DEĞERLERİ İÇİN DÜZELTME: default ve null kısıtlamaları eklendi
      t.integer :status, default: 0, null: false
      
      t.integer :credit_cost
      t.text :r_script
      t.string :output_file
      t.text :error_message

      t.timestamps
    end
  end
end
