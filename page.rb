require 'httparty'
require 'uri'
require 'nokogiri'

# a web page
class Page
  attr_accessor :uri, :links, :images

  # @param uri [URI] the uri to represent and visit
  def initialize(uri)
    @uri = uri

    # concern, this constructor is doing a bit much
    parsed ||= Nokogiri::HTML.parse(HTTParty.get(@uri).body)

    # links: all relative links and links on the root domain
    @links = parse_links(parsed)
    # images: all relative images and 
    @images = parse_images(parsed)

  rescue StandardError => e
    puts "Failed to visit or parse '#{uri}' with error: #{e}"

    @links = []
    @images = []
  end

  def to_h_as_strings
    {
      "page_url": @uri.to_s,
      "links": @links.map {|l| l.to_s},
      "images": @images.map{|i| i.to_s}
    }
  end

  private

  # document: Nokogiri::HTML::Document
  def parse_links(document)
    link_tags = document.xpath("//a")

    link_tags.filter_map do |tag|
      URI.join(@uri, tag[:href])
    end
  end

  # document: Nokogiri::HTML::Document
  def parse_images(document)
    image_tags = document.xpath("//img")

    image_tags.filter_map do |tag|
      URI.join(@uri, tag[:src])
    end
  end
end
