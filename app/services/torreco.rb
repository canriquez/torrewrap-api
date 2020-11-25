module Torreco
    class Search
        def self.by_public_id(public_id)
            Faraday.get 'https://bio.torre.co/api/bios/' + public_id
        end
    end
end