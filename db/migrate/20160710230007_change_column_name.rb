class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :label, :label
  end
end
