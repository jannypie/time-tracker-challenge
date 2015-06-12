class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :company, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :projects, :companies
  end
end
