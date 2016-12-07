class CreateUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :usuarios do |t|
      t.string :login
      t.string :senha

      t.timestamps
    end
  end
end
