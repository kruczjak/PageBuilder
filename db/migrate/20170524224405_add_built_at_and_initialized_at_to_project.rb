class AddBuiltAtAndInitializedAtToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :initialized_at, :datetime
    add_column :projects, :built_at, :datetime
  end
end
