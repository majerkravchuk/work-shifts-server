class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.string  :name, null: false
      t.integer :role, default: 0
      t.integer :position_id
      t.integer :business_id
      t.string  :type

      t.timestamps null: false
    end

    add_index :users, %i[email business_id], unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
