class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      t.string :title
      t.string :contents
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
