class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :to, :from
      t.datetime :arrive_at

      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
