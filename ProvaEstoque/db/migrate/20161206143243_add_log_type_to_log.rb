class AddLogTypeToLog < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :logtype, :string
  end
end
