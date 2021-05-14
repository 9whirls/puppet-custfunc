Puppet::Functions.create_function(:'cf_github::get_new_rel_with_token') do
  dispatch :getrel do
    param 'String', :repo
    param 'String', :token
  end

  def getrel(repo, token)
    require 'net/http'
    require 'json'
    
    uri = URI.parse("https://api.github.com/repos/#{repo}/releases/latest")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{token}"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    JSON.parse(response.body)['tag_name']
  end
end
