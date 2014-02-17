class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.datetime :duedate

      t.timestamps
    end
  end
end
