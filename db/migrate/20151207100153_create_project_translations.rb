class CreateProjectTranslations < ActiveRecord::Migration
  def change
    create_table :project_translations do |t|
      t.string :language_code
      t.string :name
      t.text :description
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
