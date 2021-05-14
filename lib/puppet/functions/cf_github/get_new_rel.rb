Puppet::Functions.create_function(:'cf_github::get_new_rel') do
  dispatch :getrel do
    param 'String', :repo
  end

  def getrel(repo)
    require 'net/http'
    require 'json'
    
    url = "https://api.github.com/repos/#{repo}/releases/latest"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['tag_name']
  end
end
