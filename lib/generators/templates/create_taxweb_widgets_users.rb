class CreateTaxwebWidgetsUsers < ActiveRecord::Migration

  def up
    unless table_exists?(:taxweb_widgets_users)
      create_table :taxweb_widgets_users do |t|
        t.references :user, index: true, foreign_key: false
        t.string :widget
        t.string :action
        t.index [:widget, :action]
      end
    end
  end

  def down
    drop_table :taxweb_widgets_users if table_exists? :taxweb_widgets_users
  end

end
