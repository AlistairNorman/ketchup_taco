require 'rails_helper'

RSpec.describe "GamesController", type: :request do
  describe "GET #new" do
    subject { get "/games/#{game_id}" }

    let(:game_id) { 2017020001 }
    let(:response_double) { double }

    before do
      allow(Faraday)
        .to receive(:get).with("https://statsapi.web.nhl.com/api/v1/game/2017020001/boxscore")
        .and_return(response_double)

      allow(response_double)
        .to receive(:body)
        .and_return(
          {
            "teams" => {
              "away" => {
                "team" => { "name" => "Toronto Maple Leafs" },
                "teamStats" => {
                  "goals" => 7,
                  "shots" => 31,
                  "hits" => 16
                }
              },
              "home" => {
                "team" => { "name" => "Winnipeg Jets" },
                "teamStats" => {
                  "goals" => 2,
                  "shots" => 37,
                  "hits" => 18
                }
              }
            }
          }.to_json
        )
    end

    it { is_expected.to render_template :show }

    it "gets the stuff" do
      expect(Faraday).to receive(:get).with("https://statsapi.web.nhl.com/api/v1/game/2017020001/boxscore")
      subject
    end
  end
end
