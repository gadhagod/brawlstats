require "json"
require "uri"
require "net/http"

def make_req url, authorization
    uri = URI url
    res = Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
        req = Net::HTTP::Get.new uri
        req["Authorization"] = authorization
        http.request req
    end
    return(JSON.parse(res.body))
end

class Brawlstats
    def initialize api_key
        @base_url = "https://api.brawlstars.com/v1"
        @authorization = "Bearer #{api_key}"
    end
    def get_player player_tag
        return make_req "#{@base_url}/players/%23#{player_tag}", @authorization
    end
    def get_player_battlelog player_tag
        return make_req "#{@base_url}/players/%23#{player_tag}/battlelog", @authorization
    end
    def get_club club_tag
        return make_req "#{@base_url}/clubs/%23#{club_tag}", @authorization
    end
    def get_club_members club_tag
        return make_req "#{@base_url}/clubs/%23#{club_tag}/members", @authorization
    end
    def get_powerplay_rankings season_id, country_code='global'
        return make_req "#{@base_url}/rankings/#{country_code}/powerplay/seasons/#{season_id}", @authorization
    end
    def get_powerplay_seasons country_code='global'
        return make_req "#{@base_url}/rankings/#{country_code}/powerplay/seasons", @authorization
    end
    def get_club_rankings country_code='global'
        return make_req "#{@base_url}/rankings/#{country_code}/clubs", @authorization
    end
    def get_brawler_rankings brawler_id, country_code='global'
        return make_req "#{@base_url}/rankings/#{country_code}/brawlers/#{brawler_id}", @authorization
    end
    def get_player_rankings country_code='global'
        return make_req "#{@base_url}/rankings/#{country_code}/players", @authorization
    end
    def get_brawlers
        return make_req "#{@base_url}/brawlers", @authorization
    end
    def get_brawler brawler_id
        return make_req "#{@base_url}/brawlers/#{brawler_id}", @authorization
    end
end