require 'httparty'
require 'uri'
require 'nokogiri'

# a web page
class Page
  attr_accessor :page_url, :links, :images

  def initialize(url)
    @page_url = URI(url)

    # concern, this constructor is doing a bit much
    parsed = Nokogiri::HTML.parse(HTTParty.get(url))
    @links = parse_links(parsed)
    @images = parse_images(parsed)
  end

  def to_h
    {
      "page_url": @page_url.to_s,
      "links": @links,
      "images": @images
    }
  end

  private

  # document: Nokogiri::HTML::Document
  def parse_links(document)
    link_tags = document.xpath("//a")
    link_tags.map {|tag| tag[:href]}
  end

  # document: Nokogiri::HTML::Document
  def parse_images(document)
    link_tags = document.xpath("//img")
    link_tags.map {|tag| tag[:src]}
  end
end
