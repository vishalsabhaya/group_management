require 'pagy/extras/overflow'

# default :empty_page (other options :last_page and :exception )
Pagy::DEFAULT[:overflow] = :last_page
Pagy::DEFAULT[:items] = 5        # items per page