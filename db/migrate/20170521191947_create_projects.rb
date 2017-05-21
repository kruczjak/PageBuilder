class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.string :uuid, null: false, unique: true, index: true
      t.string :name

      t.timestamps
    end
  end
end
