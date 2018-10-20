class PackagesController < ApplicationController
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
    return if request.headers[:HTTP_X_SIGNTURE] != OpenSSL::HMAC.hexdigest("SHA256", ENV['KISS2U_AUTH_KEY'], "data_base64=#{params[:data_base64]}")

    @pkg = Package.find_by(pkgname: pkgInfo[:pkgname])
    if @pkg
      @pkg.update pkgInfo
      #debugger
    else
      @pkg = Package.new(pkgInfo)
      @pkg.save
    end

    package = createLog @pkg

    render json: package
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

    def createLog updatePkg = @pkg

      # Filter duplicate log
      return if PackageBuildLog.find_by latest_build_time: pkgInfo[:latest_build_time]

      #debugger
      pkgInfo[:building_ok] ? updatePkg.update(successful_counts: updatePkg.successful_counts + 1) : updatePkg.update(failed_counts: updatePkg.failed_counts + 1)

      (pkg = pkgInfo).delete :pkgname
      build_log = updatePkg.package_build_log.build pkg
      build_log.save
      build_log
    end
end
