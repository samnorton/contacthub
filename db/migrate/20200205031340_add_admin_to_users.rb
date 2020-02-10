class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
     change_table :users do |t|
        t.column :admin, :boolean, default: false
     end
  end
end
