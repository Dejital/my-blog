require 'toto'
require 'uv'
require 'rack/codehighlighter'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico', '/font-face'], :root => 'public'
use Rack::CommonLogger
use Rack::Codehighlighter, :ultraviolet, :theme => "sunburst", :markdown => true, :lines => false,
  :element => "pre", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
   set :author,    'Humza'                               # blog author
   set :title,     'Second Planet | Blog'                   # site title
   set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
   set :markdown,  :smart                                    # use markdown + smart-mode
   set :disqus,    'secondplanetblog'                                     # disqus id, or false
   set :summary,   :max => 42, :delim => /~/                # length of article summary and delimiter
   set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

run toto



