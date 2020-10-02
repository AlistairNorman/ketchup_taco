class GamesController < ApplicationController
  http_basic_authenticate_with name: "pip", password: "roxie"

  def show
    response = JSON.parse(Faraday.get("https://statsapi.web.nhl.com/api/v1/game/#{params[:id]}/boxscore").body)

    @away_team = {
      name: response.dig("teams", "away", "team", "name"),
      goals: response.dig("teams", "away", "teamStats", "teamSkaterStats", "goals"),
      shots: response.dig("teams", "away", "teamStats", "teamSkaterStats", "shots"),
      hits: response.dig("teams", "away", "teamStats", "teamSkaterStats", "hits"),
    }

    @home_team = {
      name: response.dig("teams", "home", "team", "name"),
      goals: response.dig("teams", "home", "teamStats", "teamSkaterStats", "goals"),
      shots: response.dig("teams", "home", "teamStats", "teamSkaterStats", "shots"),
      hits: response.dig("teams", "home", "teamStats", "teamSkaterStats", "hits"),
    }
  end
end
