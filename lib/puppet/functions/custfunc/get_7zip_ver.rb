Puppet::Functions.create_function(:'custfunc::get_7zip_ver') do
  dispatch :getrel do
  end
  
  def getrel()
    require 'net/http'
    require 'json'
    
    url = "https://sourceforge.net/projects/sevenzip/best_release.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['platform_releases']['windows']['filename'].split('/')[2]
  end
end
