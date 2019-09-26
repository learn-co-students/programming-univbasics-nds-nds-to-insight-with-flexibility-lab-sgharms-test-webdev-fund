require 'spec_helper'

describe 'provided method' do
  describe 'flatten_a_o_a' do
    it 'flattens an a_a_a of Integers' do
      expect(flatten_a_o_a([[1,2],[3,4,5],[6]])).to eq([1,2,3,4,5,6])
    end
  end

  describe 'movie_with_director_name' do
    it "creates a new movie Hash with director's name provided" do
      director_name = "Byron Poodle"
      movies_coll = {
        :worldwide_gross => 2,
        :release_year => 2014,
        :studio => "Karbit Poodles",
        :title => "The Fire Hydrant of Doom"
      }
      new_movie = movie_with_director_name(director_name, movies_coll)

      expect(new_movie[:director_name]).to eq(director_name)
    end
  end
end

describe 'movies_with_director_key' do
  it 'adds a :director_name key an AoH of movies' do
    dir_name = "Byron Poodle"
    test_set = [{:title => "TestA"}, {:title => "TestB"}]
    updated_movies = movies_with_director_key(dir_name, test_set)
    expect(updated_movies[0][:director_name]).to eq(dir_name), "Should add director name to each movie Hash"
    expect(updated_movies[1][:director_name]).to eq(dir_name), "Should add director name to each movie Hash"
  end
end

describe 'movies_with_directors_set' do
  describe 'when given a Hash with keys :name and :movies,' do
    describe 'returns an Array of Hashes that represent movies' do
      describe 'and each Hash has a :director_name key set with the value that was in :name' do
        # This lets "sample_data" be used in the two "it" statements below
        let (:test_data) {
          [
            { :name => "Byron Poodle", :movies => [
              { :title => "At the park" },
              { :title => "On the couch" },
            ]
            },
            { :name => "Nancy Drew", :movies => [
              { :title => "Biting" },
            ]
            }
          ] 
        }

        it 'correctly "distributes" Byron Poodle as :director_name of the first film' do
          # { :name => "A", :movies => [{ :title => "Test" }] }
          # becomes... [[{:title => "Test", :director_name => "A"}], ...[], ... []]
          results = movies_with_directors_set(test_data)
          expect(results.first.first[:director_name]).to eq("Byron Poodle"),
            "The first element of the AoA should have 'Byron Poodle' as :director_name"
        end

        it 'correctly "distributes" Nancy Drew as :director_name of the last film' do
          results = movies_with_directors_set(test_data)
          expect(results.last.first[:director_name]).to eq("Nancy Drew"),
            "The last element of the AoA should have 'Nancy Drew' as :director_name"
        end
      end
    end
  end
end

describe 'gross_per_studio' do
  it 'collects each movie based on the studio key' do
    test_data = [
      { :title => "Movie A", :studio => "Alpha Films", :worldwide_gross => 10 },
      { :title => "Movie B", :studio => "Alpha Films", :worldwide_gross => 30 },
      { :title => "Movie C", :studio => "Omega Films", :worldwide_gross => 30 }
    ]
    result = gross_per_studio(test_data)
    expect(result["Alpha Films"]).to eq(40), "We should collect the totals of films made by this Alpha Films"
    expect(result["Omega Films"]).to eq(30), "We should collect the totals of films made by this Omega Films"
  end
end


describe 'The directors_database method can be processed by the studios_totals method' do
  describe "and correctly totals the directors' totals" do
    let(:expected) {
      {
       "Universal"=>1278335390,
       "Columbia"=>217711904,
       "Paramount"=>2382072020,
       "Buena Vista"=>2602319056,
       "Warner Brothers"=>1174295617,
       "Fox"=>1280043473,
       "TriStar"=>205881154,
       "Focus"=>49275340,
       "Dreamworks"=>155464351,
       "Weinstein"=>283346153,
       "Sony"=>135156125,
       "Miramax"=>508129831,
       "MGM"=>83471511
      }
    }

    it "correctly total 'Universal'" do
      expect(studios_totals(directors_database)['Universal']).to eq(expected['Universal'])
    end
    it "correctly total 'Columbia'" do
      expect(studios_totals(directors_database)['Columbia']).to eq(expected['Columbia'])
    end
    it "correctly total 'Paramount'" do
      expect(studios_totals(directors_database)['Paramount']).to eq(expected['Paramount'])
    end
    it "correctly total 'Buena Vista'" do
      expect(studios_totals(directors_database)['Buena Vista']).to eq(expected['Buena Vista'])
    end
    it "correctly total 'Warner Brothers'" do
      expect(studios_totals(directors_database)['Warner Brothers']).to eq(expected['Warner Brothers'])
    end
    it "correctly total 'Fox'" do
      expect(studios_totals(directors_database)['Fox']).to eq(expected['Fox'])
    end
    it "correctly total 'TriStar'" do
      expect(studios_totals(directors_database)['TriStar']).to eq(expected['TriStar'])
    end
    it "correctly total 'Focus'" do
      expect(studios_totals(directors_database)['Focus']).to eq(expected['Focus'])
    end
    it "correctly total 'Dreamworks'" do
      expect(studios_totals(directors_database)['Dreamworks']).to eq(expected['Dreamworks'])
    end
    it "correctly total 'Weinstein'" do
      expect(studios_totals(directors_database)['Weinstein']).to eq(expected['Weinstein'])
    end
    it "correctly total 'Sony'" do
      expect(studios_totals(directors_database)['Sony']).to eq(expected['Sony'])
    end
    it "correctly total 'Miramax'" do
      expect(studios_totals(directors_database)['Miramax']).to eq(expected['Miramax'])
    end
    it "correctly total 'MGM'" do
      expect(studios_totals(directors_database)['MGM']).to eq(expected['MGM'])
    end



  end
end
