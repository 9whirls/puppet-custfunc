Puppet::Functions.create_function(:'custfunc::get_firefox_ver') do
  dispatch :getrel do
  end
  
  def getrel()
    require 'net/http'
    require 'json'
    
    url = "https://product-details.mozilla.org/1.0/firefox_versions.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['LATEST_FIREFOX_VERSION']
  end
end
