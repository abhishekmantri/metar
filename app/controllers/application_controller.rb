
class ApplicationController < ActionController::Base

  # API for just check
  def ping
    res = Hash.new
    res['data'] = 'pong'
    render json: res
  end

  # API returning the metar info
  def metar_info
    # Fetching data from cache
    info = $redis.get("#{params[:scode]}_data")
    if info && !(params.has_key?(:nocache) && params[:nocache] == '1')
      $redis.set("#{params[:scode]}_data", info, {:ex => 300})
      render json: info
    else
      address = 'http://tgftp.nws.noaa.gov/data/observations/metar/stations/'
      if params.has_key?('scode') && params[:scode]
        address += "#{params[:scode].upcase}.TXT"
      end
      res = HTTP.get(address)
      res = HTTP.get(res['location'])
      if res.status == 200
        data = res.body.to_s
        response = {}
        response['data'] = ApplicationHelper.convert_data(data)
        # Storing as cache with expiry time of 5 minutes
        $redis.set("#{params[:scode]}_data", response, {:ex => 300})
        render json: response
      elsif res.status == 404
        render json: {error: 'Data not found for station'}
      end
    end
  end

end
