require 'open-uri'
require 'json'

class PackagesCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if (list = get_list).length > 0
      orphan_lists = fliter_orphans(list)
      orphan_lists.each { |pkgname| Package.find_by(pkgname: pkgname).destroy }
      logger.info "Cleanup orphans package: #{orphan_lists}"
    end
  end

  def get_list
    begin
      list = []
      root_api = 'https://api.github.com/repos/archlinuxcn/repo/git/trees/master'
      archlinuxcn_api = ''

      # /repo
      open(root_api) do |f|
        JSON.parse(f.read)['tree'].each { |i|
          list << i['path']
          archlinuxcn_api = i['url'] if i['path'] == "archlinuxcn"
        }
      end

      unless archlinuxcn_api == ''

        # /repo/archlinuxcn
        open(archlinuxcn_api) do |f|
          JSON.parse(f.read)['tree'].each { |i| list << i['path'] }
        end
      end

      list
    rescue
      []
    end
  end

  def fliter_orphans list
    packages = []
    Package.all.each { |i| packages << i['pkgname'] }

    packages - list
  end

end
