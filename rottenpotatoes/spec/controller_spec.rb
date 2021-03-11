require 'rails_helper'

FactoryGirl.define do
  factory :movie do
    title "Course Name"
    rating "G"
  end
end

describe MoviesController, type: :controller do
    describe "GET index" do
        it "assign @movies" do
            movie_1 = create(:movie)
            movie_2 = create(:movie)

            get :index
            
            expect(assigns[:movies]).to include(movie_1)
            expect(assigns[:movies]).to include(movie_2)
        end
        
        it "should render template" do
            #movie_1 = create(:movie)
            #movie_2 = create(:movie)

            get :index
            
            expect(response).to render_template("index")
        end
    end
   
    describe "GET show" do
        it "assign @movies" do
            movie = create(:movie)

            get :show, :id => movie.id
            
            
            expect(assigns[:movie]).to eq(movie)

            
            expect(response).to render_template("show")
        end
    end
    
    
    describe "GET new" do
        it "should render new" do
            
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe "POST create" do
        it "should create a new record and redirect" do 
            movie = build(:movie)
            expect do
              post :create, :movie => attributes_for(:movie)
            end.to change{ Movie.count }.by(1)   
            
            expect(response).to redirect_to movies_path
        end
    
    end
    
    describe "GET edit" do
        it "should render to edit template" do
            movie = create(:movie)
            get :edit, :id => movie.id
            #expect(assigns[:course]).to eq(course)
            expect(response).to render_template("edit")
        end
        
    end
    
    describe "PUT update" do
        it "should change value and redirects" do
            
            movie = create(:movie)
            put :update ,  :id => movie.id, :movie=> { title: "I LOVE ZZH", rating: "G" }
            expect(assigns[:movie].title).to eq("I LOVE ZZH")
            expect(assigns[:movie].rating).to eq("G")
            expect(response).to redirect_to movie_path(movie)
        end
    end

    describe "DELETE  destroy" do
        it "should deletes record and redirects" do
            
            movie = create(:movie)
            expect { delete :destroy, id: movie.id }.to change { Movie.count }.by(-1)
            expect(response).to redirect_to movies_path
        end
    end
    
    describe "GET find_similar" do
		let!(:movie_1) {Movie.create!({title: 'EVA', rating: 'R', description: nil})}
		let!(:movie_2) {Movie.create!({title: 'I Love U', rating: 'R', description: nil, director: "Me"})}
		let!(:movie_3) {Movie.create!({title: 'I Love U Too', rating: 'G', description: nil, director: "Me"})}
        context "when director is nil" do
            it "should find no similar movie and render to movies list" do
                get :find_similar, :id => movie_1.id
                expect(response).to redirect_to movies_path
            end
        end
        
        context "when director is not nil" do
            it "should find similar movie with same director and render" do
                get :find_similar, :id => movie_2.id
                expect(response).to render_template("find_similar")
            end
        end        
    end

end