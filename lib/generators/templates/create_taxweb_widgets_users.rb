class CreateDashboardSettings < ActiveRecord::Migration

  def up
    unless table_exists?(:dashboard_settings)
      create_table :dashboard_settings do |t|
        t.references :user, index: true, foreign_key: false
        t.string :widget
        t.string :action
        t.index [:widget, :action]
      end
    end
  end

  def down
    drop_table :dashboard_settings if table_exists? :dashboard_settings
  end

end
