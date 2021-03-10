require 'rails_helper'

describe Movie do
	describe "Test the find_similar_movies method"  do
	    before(:all) do
	        @movie_1 = Movie.create!(:director => "AAA")
	        @movie_2 = Movie.create!(:director => "AAA")
	        @movie_3 = Movie.create!(:director => "BBB")
	        @movie_4 = Movie.create!(:director => "")
	    end
	    
	    it "should find similar movies with same director name" do
	        expect(Movie.find_similar_movies(movie_1[:id])).to include(movie_1)
	        expect(Movie.find_similar_movies(movie_1[:id])).to include(movie_2)
	    end
	    
	    it "should not find similar movies with different director name" do
	        expect(Movie.find_similar_movies(movie_1[:id])).to_not include(movie_3)
	        expect(Movie.find_similar_movies(movie_1[:id])).to_not include(movie_4)
	    end
	    
	end
end