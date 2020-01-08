class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :phone
      t.string :country
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :note

      t.timestamps
    end
  end
end
