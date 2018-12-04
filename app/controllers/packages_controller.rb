class PackagesController < ApplicationController
  before_action :filter_repetition, only: [:create]

  def index
    render json: Package.all.order(latest_build_time: :desc)
  end

  def show
    pkg = Package.find_by pkgname: params[:id]
    render json: {
      latest: pkg,
      log: pkg.package_build_log.order(latest_build_time: :desc)
    }
  end

  def create
    return if request.headers[:HTTP_X_SIGNTURE] != OpenSSL::HMAC.hexdigest("SHA256", ENV['KISS2U_AUTH_KEY'] || '', "data_base64=#{params[:data_base64]}")

    pkg_info = pkgInfo
    unless pkg = Package.find_by(pkgname: pkg_info[:pkgname])
      (pkg = Package.new(pkg_info)).save
    end

    pkg.update pkg_info

    render json: pkg
  end

  def cleanup
    time_now = Time.new
    #@@clean_time ||= time_now

    # 调用频次限制 (s)
    time_interval = 3600

    if time_now - (@@clean_time ||= time_now) > time_interval
      @@clean_time = time_now

      PackagesCleanupJob.perform_later
      render json: {
        status: :cleaning
      }
    else
      render json: {
        status: "Please wait #{time_interval - (time_now - @@clean_time)} s"
      }
    end
  end

  private
    def pkgInfo data = Base64.decode64(params[:data_base64])
      #debugger

      # https://github.com/archlinuxcn/repo/issues/794

      {
        pkgname: data.split[2],
        #pkgver: data.split[3],
        # 考虑到版本号可能会有空格的情况
        pkgver: data.split.drop(3).reverse.drop(data.split.drop(3).to_s =~ /after/ ? 3 : 1).reverse.join(' ').gsub(/.*\[/, '').gsub(/\]/, ''),
        #latest_build_time: data.split("]")[0].split("[")[1],
        latest_build_time: DateTime.parse(data.split("]")[0].split("[")[1] + "+08:00"),
        building_ok: data.split.drop(3).to_s =~ /successful/ ? true : false,
        building_time: data.split.drop(3).to_s =~ /after/ ? data.split[-1].split("s")[0].to_i : 0
      }
    end

    def filter_repetition
      if PackageBuildLog.find_by latest_build_time: pkgInfo[:latest_build_time]
        render json: {
          status: :repetition
        }
      end
    end
end
