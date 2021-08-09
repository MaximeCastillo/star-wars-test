require 'open-uri'

module RequestHelper
  def get(url)
    res = URI.open(url).read
    return JSON.parse(res)
  end
end
