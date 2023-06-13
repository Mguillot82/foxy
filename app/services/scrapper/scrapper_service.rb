require "open-uri"
require "nokogiri"

module Scrapper
  class ScrapperService
    def scrapper(url)
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML.parse(html_file)
      description = []

      div_description = html_doc.search("#mw-content-text .mw-parser-output")
      div_description.search('>p:not([class])').first(3).each do |content|
        description << content.text.strip
      end
      image_place = html_doc.search(".image img")[1]
      image_url = "https:#{image_place.attribute("src").value}"

      hash_returned = {
        description: description.join,
        image_url: image_url,
      }
      hash_returned.to_json
    end
  end
end
