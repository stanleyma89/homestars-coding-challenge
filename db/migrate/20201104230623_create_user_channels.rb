class CreateUserChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :user_channels do |t|
      t.references :user, index: true, foreign_key: true
      t.references :channel, index: true, foreign_key: true

      t.timestamps
    end
  end
end
