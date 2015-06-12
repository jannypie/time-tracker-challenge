class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # NOTE: Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      # NOTE: Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # NOTE: Rememberable
      t.datetime :remember_created_at

      # NOTE: Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # NOTE: We may add an 'Admin' type in the future
      t.string :type

      # NOTE: For token authentication
      t.string :authentication_token, index: true

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
