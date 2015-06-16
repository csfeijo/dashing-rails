require 'rest-client'

git_token = ""
git_owner = ""
git_project = "the-art-of-command-line"

user = 'jlevy'
repo = 'the-art-of-command-line'

uri  = "https://api.github.com/repos/#{user}/#{repo}/pulls"

SCHEDULER.every '1m', :first_in => 0 do |job|

  resp = RestClient.get uri
  json = JSON.parse(resp.body, symbolize_names: true)

  send_event('pull_count', {title: "Active Pull Requests", text: "#{json.size}"})
  
end

SCHEDULER.every '1m', :first_in => 0 do |job|
  #resp = RestClient.get uri
  #json = JSON.parse(resp.body, symbolize_names: true)
  json = [0,1,2,3,4]
  
  
  items = [];
  
  json.each do |i|
    items.push({ label: "Pull Request Name #{i}", text: 'text' })
  end
  
  send_event('pull_list', {title: "Active Pull Requests", items: items})
  
end
