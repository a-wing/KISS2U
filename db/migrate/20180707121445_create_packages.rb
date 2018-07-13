class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string    :pkgname
      t.string    :pkgver
      t.datetime  :latest_build_time
      t.boolean   :building_ok
      t.integer   :building_time
      t.integer   :successful_counts, null: false, default: 0
      t.integer   :failed_counts, null: false, default: 0

      t.timestamps
    end
  end
end
