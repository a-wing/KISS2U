class Package < ApplicationRecord
  has_many :package_build_log, dependent: :destroy
end
