class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :role_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
