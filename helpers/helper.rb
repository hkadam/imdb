   class Helper

          def response     #gets json response with api key using Rest client gem
           @response = RestClient.get 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=hz54u92dhdukkcmxpmyr6rbk'
          end


          def create_file   #saves the json response in a text file
            start = Time.now                                              #gets current linux time
            File.open("./reports/rottentomatoes_output.txt","w") do |f|
              f.write(response)
              finish = Time.now
              total_time = finish - start                                 #calculates total execution time
            end
          end


           def parse_rottentomatoes_output          #parses the rottentomatoes output from rottentomatoes_output.txt
             report = File.open("./reports/rottentomatoes_output.txt", "r")

             rottentomatoes_output = ""
             report.each do |line|
               rottentomatoes_output << line
             end
             report.close
             @report_in_json = JSON.parse(rottentomatoes_output)
           end


          def find_imdb_id
            @find_imdb_id = @report_in_json['movies'][0]
          end


          def parse_img_count_output                  #parses the rottentomatoes output from img_count_output.txt
            image_count_report = File.open("./reports/img_count_output.txt", "r")

            output = ""
            image_count_report.each do |line|
              output << line
            end
            image_count_report.close
            @json_report = JSON.parse(output)
            @imdb_id = @json_report[0]["imdb_id"]
            @url = @json_report[0]["url"]
          end



          def img_count_output_report
            @json_report[0]
          end


             def get_all_imdb_ids
               imdb_ids = @report_in_json["movies"].map { |h| h['alternate_ids'] }
               puts imdb_ids
             end


             def get_imdb_id
               @rottentomatoes_imdb_id = @report_in_json['movies'][0]['alternate_ids']['imdb']
             end


             def total_movies
               @report_in_json['total']

             end

             def get_response_code  #gets status code
               @response.code
             end

             def verify_report_exists
                File.exist?('./reports/img_count_output.txt')
             end
          end
