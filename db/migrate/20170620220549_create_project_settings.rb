class CreateProjectSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :project_settings do |t|
      t.references :project, null: false, index: true, foreign_key: true
      t.string :git_remote_url
      t.string :git_sshkey

      t.timestamps
    end
  end
end
