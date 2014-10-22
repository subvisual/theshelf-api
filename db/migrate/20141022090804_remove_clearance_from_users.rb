class RemoveClearanceFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :encrypted_password
      t.remove :confirmation_token
      t.remove :remember_token
    end
  end
end
