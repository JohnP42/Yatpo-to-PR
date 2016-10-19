require 'date'
require 'csv'

if(ARGV[0])
	id = 1

	CSV.open(ARGV[1] ? ARGV[1] : "output.csv", "wb") do |csv|

		csv << ["Review Status", "Review Title", "Review Text", "Rating", "Review Date", "Review Source", "Page Id", "Review Display", "User Email", "Merchant Response", "Review Id", "Review Location"]

		CSV.foreach(ARGV[0]) do |row|

			next if row[0] == "appkey"

			pr_row = [];
			pr_row << (row[1] == "true" ? "APPROVED" : "REJECTED")
			pr_row << row[2]
			pr_row << row[3]
			pr_row << row[4]
			pr_row << Date.parse(row[5]).strftime("%m/%d/%Y")
			pr_row << (row[6] == "verified_buyer" ? "email" : "web")
			pr_row << row[7]
			pr_row << row[13] 
			pr_row << row[14]
			pr_row << row[15]
			pr_row << id
			id += 1
			pr_row << "Not Disclosed"
			csv << pr_row
		end
	end
else
	puts "Put the name of the input file as an argument"
	puts "Ex: ruby converter.rb test.csv"
	puts "You can also name the output file"
	puts "Ex: ruby converter.rb test.csv named-file.csv"
end