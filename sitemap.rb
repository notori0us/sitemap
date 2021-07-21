require_relative 'page'

def site_map(starting_url: 'https://mozilla.org', max_depth: 10)
  discovered = {}
  search_recursive(URI(starting_url), discovered, max_depth)

  puts "Writing file 'sitemap.json'"
  File.open('sitemap.json', 'w') do |f|
    f.write(JSON.pretty_generate(discovered.values.map {|page| page.to_h_as_strings}))
  end
end


def search_recursive(current_uri, discovered, max_depth)
  puts "Visiting #{current_uri.to_s}"
  current_page = Page.new(current_uri)
  discovered[current_uri.to_s] = current_page

  current_page.links.each do |link|
    if !discovered.key?(link.to_s) && max_depth > 0 && same_domain?(current_page.uri, link)
      search_recursive(link, discovered, max_depth - 1)
    end
  end
end

def same_domain?(current_page, link)
  current_page.host == link.host
end

if ARGV.length >= 2
  site_map(starting_url: ARGV[0], max_depth: ARGV[1].to_i)
elsif ARGV.length == 1
  site_map(starting_url: ARGV[0])
else
  site_map
end
