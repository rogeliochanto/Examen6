require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    url = URI("#{url}api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end


def buid_web_page(info_hash)
    # print info_hash['photos'][0]['img_src']
    File.open('index.html','w') do |file|
        file.puts "<html>"
        file.puts "<head>" 
        file.puts "</head>"
        file.puts "<body>"
        file.puts "<ul>"
        info_hash["photos"].each do |photo_hash|
            file.puts "<li><img src='#{photo_hash["img_src"]}'width = '100'></li>"

        end
        file.puts "<li> Largo: #{info_hash["photos"].length}</li>" 
        file.puts "</ul>"
        file.puts "</body>"
        file.puts "</html>"
    end
end

nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&","IULM5B9ZddV644lZrD2TAWsCZTu9Lbgue9Yhn2rB")
puts buid_web_page(nasa_array)