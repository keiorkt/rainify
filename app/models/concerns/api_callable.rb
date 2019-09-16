require 'uri'
require 'net/http'
require 'net/https'

module ApiCallable
  def getRequest(uri_string, route='/', payload={})
    uri = URI.join(uri_string, route)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.port == 443
    uri.query = payload.to_param
    req = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(req)
    result = ActiveSupport::JSON.decode(res.body)
  end

  def postRequest(uri_string, route='/', payload={})
    uri = URI.join(uri_string, route)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.port == 443
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    payload = payload.to_json
    req.body = payload
    res = http.request(req)
    result = ActiveSupport::JSON.decode(res.body)
  end
end