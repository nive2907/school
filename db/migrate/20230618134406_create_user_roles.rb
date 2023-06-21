class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.bigint :user_id
      t.string :user_type
      t.integer :role_id
      t.timestamps
    end
  end
end
