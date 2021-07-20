require_relative 'page'

# nice to haves:
# * use ARGV instead of hardcoding url
# * write to file instead of using *nix stdout

def site_map(starting_url: 'https://mozilla.com', max_depth: 10)

  search_iterative(starting_url).map {|page| page.to_h}.to_json

end


# run iterative DFS
# the main problem with this approach is that it's hard to limit our depth. So let's avoid this
def search_iterative(url)
  discovered = {}
  stack = []
  stack.push(url)

  while stack.any?
    current_url = stack.pop

    unless discovered.key?(current_url)
      current_page = Page.new(current_url)
      discovered[current_url] = current_page
      stack.push(*current_page.links) # push all children
    end
  end

  discovered.values
end

site_map
