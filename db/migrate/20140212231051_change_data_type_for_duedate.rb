class ChangeDataTypeForDuedate < ActiveRecord::Migration
  def change
    change_column :items, :duedate, :date
  end
end
