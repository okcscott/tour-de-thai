require 'sinatra'
require "google_drive"
require 'json'

get "/" do
  session = GoogleDrive.login(ENV["google_user_name"], ENV["google_password"])
  @ws = session.spreadsheet_by_key(ENV["google_spreadsheet_key"]).worksheets[0]
  erb :index
end

get "/scores" do
  content_type :json

  session = GoogleDrive.login(ENV["google_user_name"], ENV["google_password"])
  ws = session.spreadsheet_by_key(ENV["google_spreadsheet_key"]).worksheets[0]

  scores = []

  for row in 1..ws.num_rows
    scores << {:name => ws[row,1], :score => ws[row,2]}
  end

  scores.to_json
end