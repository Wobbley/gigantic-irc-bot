module Cinch
  module Plugins
    #Monkey Patch so it only prints the title...I feel ashamed
    class LinksTitles

      def post_title(m, link)
        return if link.title.nil?
        m.reply "^ #{link.title} ^ "
      end
    end
  end
end