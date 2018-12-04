class Package < ApplicationRecord
  has_many :package_build_log, dependent: :destroy

  before_update :update_counts
  after_update :create_log

  def update_counts
    building_ok ? update_columns(successful_counts: successful_counts + 1) : update_columns(failed_counts: failed_counts + 1)
  end

  def create_log
    package_build_log.build(pkgver: pkgver, latest_build_time: latest_build_time, building_ok: building_ok, building_time: building_time).save
  end
end
