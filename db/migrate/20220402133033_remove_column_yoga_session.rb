class RemoveColumnYogaSession < ActiveRecord::Migration[7.0]
  def change
    remove_column :yoga_sessions, :time
    change_column :yoga_sessions, :date, :datetime
  end
end
