class CreateTaxwebWidgetsAlerts < ActiveRecord::Migration

  def up
    unless table_exists?(:taxweb_widgets_alerts)
      create_table :taxweb_widgets_alerts do |t|
        t.string :mtype, null: false
        t.text :message, null: false
        t.integer :timeout, null: false, default: 0
        t.date :start, null: false
        t.date :end, null: false
      end
    end
  end

  def down
    drop_table :taxweb_widgets_alerts if table_exists? :taxweb_widgets_alerts
  end

end
