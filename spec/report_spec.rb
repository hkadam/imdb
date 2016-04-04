    require 'rspec'
    require 'rspec/retry'
    require 'rest_client'
    require 'json'
    require './helpers/helper'


        describe "reports verification script", :type => :feature do
          let(:helper) { Helper.new }
          let(:generate_output) { Helper.create_file }

          it "reports generated should be a text file, named as img_count_output.txt", :retry => 1, :retry_wait => 5 do

            expect(helper.verify_report_exists).to eq(true)
            expect(helper.verify_report_exists).to be_truthy      # passes if obj is truthy (not nil or false)

          end


          it "verify rottentomatoes.com API is working", :retry => 1, :retry_wait => 5 do

            expect(helper.response.code).to eq(200)  #verifies response status code is 200

          end


          it "verify img_count_output.txt has a valid json format data with fields url,count and imdb_id", :retry => 1, :retry_wait => 5 do

            helper.parse_rottentomatoes_output
            helper.parse_img_count_output
            expect(helper.img_count_output_report).to include("url","count","imdb_id")  # Verifies the text file has fields url,count and imdb_id
            #expect(helper.total_movies).to eq(98)    # the total movie count will change all the time based on new movies added or removed
          end


          it "first movie imdb_id in the img_count_output.txt report matches the imdb id in rottentomatoes.com API response ", :retry => 1, :retry_wait => 5 do


            helper.parse_img_count_output
            expect(@imdb_id).to eq(@rottentomatoes_imdb_id)

          end

          it "verify rottentomatoes.com API response has a imdb id", :retry => 1, :retry_wait => 5 do

            helper.parse_rottentomatoes_output
            expect(helper.find_imdb_id).to include("alternate_ids" => {"imdb"=>"2975590"})

          end

          it "program must complete execution in under 8 seconds", :retry => 1, :retry_wait => 5 do

         #assuming create_file is img_count.py which executes and generates a report img_count_output.txt in reports dir

           expect(helper.create_file).to be < 8
         end
       end
