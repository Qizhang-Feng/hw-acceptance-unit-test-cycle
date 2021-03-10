class Movie < ActiveRecord::Base
    def self.find_similar_movies(id)
        director_name = self.find(id).director
        return self.where(director: director_name).all
    end
end
