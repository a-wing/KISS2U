class CreatePackageBuildLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :package_build_logs do |t|
      t.belongs_to:package
      t.string    :pkgver
      t.datetime  :latest_build_time
      t.boolean   :building_status
      t.integer   :building_time

      t.timestamps
    end
  end
end
