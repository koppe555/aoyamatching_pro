class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :user, foreign_key: true
      t.references :recruit, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
