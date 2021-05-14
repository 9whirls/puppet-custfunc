Puppet::Functions.create_function(:'cf-github::get_new_rel') do
  dispatch :getrel do
    param 'String', :repo
  end

  def getrel(repo, token)
    require 'net/http'
    require 'json'
    
    url = "https://api.github.com/repos/#{repo}/releases/latest"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['tag_name']
  end
end
